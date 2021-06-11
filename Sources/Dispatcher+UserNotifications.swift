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
                                     withCompletionHandler completionHandler: @escaping VoidHandler) -> Bool {
    for service in allServices.compactMap({ $0 as? UserNotificationsService }) {
      if service.handleUserNotificationsResponse(response: response, from: center, with: completionHandler) {
        return true
      }
    }
    return false
  }

  //swiftlint:disable line_length
  public func userNotificationCenter(_ center: UNUserNotificationCenter,
                                     willPresent notification: UNNotification,
                                     withCompletionHandler completionHandler: @escaping NotificationPresentationOptionsHandler) -> Bool {
    for service in allServices.compactMap({ $0 as? UserNotificationsService }) {
      if service.handleUserNotificationsWillPresent(notification: notification, from: center, with: completionHandler) {
        return true
      }
    }
    return false
  }
  //swiftlint:enable line_length

}
