//
//  AppService.swift
//  Astrarium
//
//  Created by Dmitry Duleba on 5/23/18.
//
import UIKit
import UserNotifications

public protocol AppService: ServiceInitiable {

  /// will call setup in willFinishLaunch if 'true',
  /// otherwise in didFinishLaunch
  var shouldSetupEarly: Bool { get }

  func setup(with launchOptions: LaunchOptions)

  func applicationWillFinishLaunch(with options: LaunchOptions?)

  func applicationDidFinishLaunch(with options: LaunchOptions?)

  func applicationDidBecomeActive()

  func applicationWillResignActive()

  func applicationWillEnterForeground()

  func applicationDidEnterBackground()

  func application(_ app: UIApplication, open url: URL, options: OpenURLOptions) -> Bool

  @available(iOS 10.0, *)
  func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse,
                              withCompletionHandler completionHandler: @escaping () -> Void)

  @available(iOS 10.0, *)
  //swiftlint:disable line_length
  func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification,
                              withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void)
  //swiftlint:enable line_length

  func applicationWillTerminate()
}

// MARK: - Defaults

public extension AppService {

  public var shouldSetupEarly: Bool { return false }

  public func applicationWillFinishLaunch(with options: LaunchOptions?) {}

  public func applicationDidFinishLaunch(with options: LaunchOptions?) {}

  public func applicationDidBecomeActive() {}

  public func applicationWillResignActive() {}

  public func applicationWillEnterForeground() {}

  public func applicationDidEnterBackground() {}

  public func handle(_ url: URL, sourceApplication: String?, annotation: Any?) -> Bool { return false }

  public func application(_ app: UIApplication, open url: URL, options: OpenURLOptions) -> Bool {
    return false
  }

  @available(iOS 10.0, *)
  public func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse,
                              withCompletionHandler completionHandler: @escaping () -> Void) { }

  @available(iOS 10.0, *)
  //swiftlint:disable line_length
  public func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification,
                              withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) { }
  //swiftlint:enable line_length

  public func applicationWillTerminate() {}
}
