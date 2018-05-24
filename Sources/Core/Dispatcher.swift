//
//  Dispatcher.swift
//  Astrarium
//
//  Created by Dmitry Duleba on 5/23/18.
//

import UIKit
import UserNotifications

public class ServiceIds {

  fileprivate let key: String

  fileprivate init(key: String) {
    self.key = key
  }

  fileprivate func instanciateService() -> AppService {
    fatalError("Abstract method. Should not be called directly")
  }
}

public class ServiceIdentifier<T: AppService>: ServiceIds {

  public convenience init() {
    self.init(key: "\(T.self)")
  }

  override public func instanciateService() -> AppService {
    return T.init()
  }
}

final public class Dispatcher: NSObject {

  private let identifiers: [ServiceIds]
  private var initializedServices = [String: AppService]()

  private lazy var allServices: [AppService] = identifiers
    .compactMap { _service(for: $0) }

  // MARK: - Shared

  private static var registeredSharedDispatcher: Dispatcher?
  public static var shared: Dispatcher {
    guard let shared = registeredSharedDispatcher else {
      fatalError("Shared dispatcher has not been registered")
    }
    return shared
  }

  internal class func register(shared: Dispatcher) {
    registeredSharedDispatcher = shared
  }

  // MARK: - Init

  required public init(services: [ServiceIds?]) {
    identifiers = services.compactMap { $0 }
    super.init()
    if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().delegate = self
    }
  }

  // MARK: - Public

  public func service<T: AppService>(for identifier: ServiceIdentifier<T>) -> T? {
    return _service(for: identifier) as? T
  }

  public subscript<T: AppService>(identifier: ServiceIdentifier<T>) -> T {
    guard let service = service(for: identifier) else {
      fatalError("Service with \(identifier) is not present in services list")
    }
    return service
  }

  public subscript<T: AppService>(safe identifier: ServiceIdentifier<T>) -> T? {
    return service(for: identifier)
  }
}

// MARK: - Private

private extension Dispatcher {

  func _service(for identifier: ServiceIds) -> AppService? {
    if let service = initializedServices[identifier.key] {
      return service
    }
    if identifiers.contains(where: { $0.key == identifier.key }) {
      let newService = identifier.instanciateService()
      initializedServices[identifier.key] = newService
      return newService
    }
    return nil
  }
}

// MARK: - UIApplicationDelegate

extension Dispatcher: UIApplicationDelegate {

  @discardableResult
  public func application(_ application: UIApplication,
                          willFinishLaunchingWithOptions launchOptions: LaunchOptions? = nil) -> Bool {
    allServices.filter { $0.shouldSetupEarly }
      .forEach { $0.setup(with: launchOptions ?? [:]) }
    allServices.forEach { $0.applicationWillFinishLaunch(with: launchOptions) }
    return true
  }

  @discardableResult
  public func application(_ application: UIApplication,
                          didFinishLaunchingWithOptions launchOptions: LaunchOptions?) -> Bool {
    allServices.filter { !$0.shouldSetupEarly }
      .forEach { $0.setup(with: launchOptions ?? [:]) }
    allServices.forEach { $0.applicationDidFinishLaunch(with: launchOptions) }
    return true
  }

  public func applicationDidBecomeActive(_ application: UIApplication) {
    allServices.forEach { $0.applicationDidBecomeActive() }
  }

  public func applicationWillResignActive(_ application: UIApplication) {
    allServices.forEach { $0.applicationWillResignActive() }
  }

  public func applicationWillEnterForeground(_ application: UIApplication) {
    allServices.forEach { $0.applicationWillEnterForeground() }
  }

  public func applicationDidEnterBackground(_ application: UIApplication) {
    allServices.forEach { $0.applicationDidEnterBackground() }
  }

  public func application(_ app: UIApplication, open url: URL, options: OpenURLOptions = [:]) -> Bool {
    for service in allServices {
      if service.application(app, open: url, options: options) {
        return true
      }
    }
    return false
  }

  public func applicationWillTerminate(_ application: UIApplication) {
    allServices.forEach { $0.applicationWillTerminate() }
  }
}

// MARK: - UNUserNotificationCenterDelegate

@available(iOS 10.0, *)
extension Dispatcher: UNUserNotificationCenterDelegate {

  public func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse,
                                     withCompletionHandler completionHandler: @escaping () -> Void) {
    allServices.forEach {
      $0.userNotificationCenter(center, didReceive: response, withCompletionHandler: completionHandler)
    }
  }

  //swiftlint:disable line_length
  public func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification,
                                     withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    allServices.forEach {
      $0.userNotificationCenter(center, willPresent: notification, withCompletionHandler: completionHandler)
    }
  }
  //swiftlint:enable line_length
}
