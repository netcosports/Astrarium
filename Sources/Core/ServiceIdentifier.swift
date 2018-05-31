//
//  ServiceIdentifier.swift
//  Astrarium
//
//  Created by Dmitry Duleba on 5/31/18.
//

import Foundation

public class ServiceIds {

  internal let key: String

  internal init(key: String) {
    self.key = key
  }

  internal func instanciateService() -> AppService {
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
