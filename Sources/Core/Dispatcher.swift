//
//  Dispatcher.swift
//  Astrarium
//
//  Created by Dmitry Duleba on 5/23/18.
//

import UIKit

final public class Dispatcher {

  internal let identifiers: [ServiceIds]
  internal var initializedServices = [String: AppService]()

  internal lazy var allServices: [AppService] = identifiers
    .compactMap { internalService(for: $0) }

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

  public init() {
    fatalError("should not be called directly")
  }

  required public init(services: [ServiceIds?]) {
    identifiers = services.compactMap { $0 }
  }

  // MARK: - Public

  public func setup(with launchOptions: LaunchOptions) { }

  public func service<T: AppService>(for identifier: ServiceIdentifier<T>) -> T? {
    return internalService(for: identifier) as? T
  }

  public subscript<T: AppService>(force identifier: ServiceIdentifier<T>) -> T {
    guard let service = service(for: identifier) else {
      fatalError("Service with \(identifier) is not present in services list")
    }
    return service
  }

  public subscript<T: AppService>(identifier: ServiceIdentifier<T>) -> T? {
    return service(for: identifier)
  }
}

// MARK: - Internal

extension Dispatcher {

  func internalService(for identifier: ServiceIds) -> AppService? {
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
