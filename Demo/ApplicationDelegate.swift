//
//  ApplicationDelegate.swift
//  Astrarium
//
//  Created by Dmitry Duleba on 5/23/18.
//

import UIKit
import Astrarium

//swiftlint:disable:next identifier_name
var Services: Dispatcher {
  return Dispatcher.shared
}

@UIApplicationMain
class ApplicationDelegate: Astrarium.AppDelegate {

  override var services: [ServiceIds?] {
    [
      .ui,
      .remote,
      .configurableDebugService,
      .configurableProductionService
    ]
  }

  var window: UIWindow? {
    get { return Services[.ui]?.window }
    // swiftlint:disable:next unused_setter_value
    set { assertionFailure("window setted should not be called directly") }
  }

}
