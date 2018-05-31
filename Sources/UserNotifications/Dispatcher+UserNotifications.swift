//
//  Dispatcher+UserNotifications.swift
//  Astrarium
//
//  Created by Dmitry Duleba on 5/31/18.
//

import Foundation
import UserNotifications

@available(iOS 10.0, *)
extension Dispatcher {

  public func userNotificationCenter(_ center: UNUserNotificationCenter,
                                     didReceive response: UNNotificationResponse,
                                     withCompletionHandler completionHandler: @escaping VoidHandler) {
//    allServices.forEach {
//      $0.userNotificationCenter(center, didReceive: response, withCompletionHandler: completionHandler)
//    }
  }

  //swiftlint:disable line_length
  public func userNotificationCenter(_ center: UNUserNotificationCenter,
                                     willPresent notification: UNNotification,
                                     withCompletionHandler completionHandler: @escaping NotificationPresentationOptionsHandler) {
//    allServices.forEach {
//      $0.userNotificationCenter(center, willPresent: notification, withCompletionHandler: completionHandler)
//    }
  }
  //swiftlint:enable line_length
}
