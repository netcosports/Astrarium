//
//  AppDelegate+Intents.swift
//  Astrarium
//
//  Created by Dmitry Duleba on 5/31/18.
//

import Foundation
import Intents

@available(iOS 10.0, *)
public typealias IntentResponseHandler = (INIntentResponse) -> Swift.Void

extension AppDelegate {

  @available(iOS 11.0, *)
  open func application(_ application: UIApplication,
                        handle intent: INIntent,
                        completionHandler: @escaping IntentResponseHandler) {
    dispatcher.application(application, handle: intent, completionHandler: completionHandler)
  }
}
