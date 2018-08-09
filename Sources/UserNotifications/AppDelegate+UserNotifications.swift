//
//  AppDelegate+UserNotifications.swift
//  Astrarium
//
//  Created by Dmitry Duleba on 5/31/18.
//

import Foundation
import UserNotifications

@available(iOS 10.0, *)
public typealias NotificationPresentationOptionsHandler = (UNNotificationPresentationOptions) -> Void

@available(iOS 10.0, *)
extension AppDelegate: UNUserNotificationCenterDelegate {

  //swiftlint:disable line_length
  open func userNotificationCenter(_ center: UNUserNotificationCenter,
                                   willPresent notification: UNNotification,
                                   withCompletionHandler completionHandler: @escaping NotificationPresentationOptionsHandler) {
    if dispatcher.userNotificationCenter(center, willPresent: notification, withCompletionHandler: completionHandler) {
      return
    }

    completionHandler(UNNotificationPresentationOptions(rawValue: 0))
  }
  //swiftlint:enable line_length

  open func userNotificationCenter(_ center: UNUserNotificationCenter,
                                   didReceive response: UNNotificationResponse,
                                   withCompletionHandler completionHandler: @escaping VoidHandler) {
    dispatcher.userNotificationCenter(center, didReceive: response, withCompletionHandler: completionHandler)
  }
}
