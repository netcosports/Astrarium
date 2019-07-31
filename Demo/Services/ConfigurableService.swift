//
//  ConfigurableService.swift
//  Astrarium
//
//  Created by Dmitry Duleba on 4/9/19.
//

import Astrarium

extension ServiceIds {

  static let configurableDebugService = ServiceIdentifier { ConfigurableService(.debug) }

  static let configurableProductionService = ServiceIdentifier { ConfigurableService(.production) }

}

protocol StagingService: AppService { }

final class ConfigurableService: StagingService {

  enum Intent {
    case mockup
    case debug
    case production
  }

  let intent: Intent

  required init(_ intent: Intent) {
    self.intent = intent
  }

  required init() { fatalError("Use init(_ intent:) instead") }

  func setup(with launchOptions: LaunchOptions) { }

}
