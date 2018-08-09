//
//  UserNotificationsService.swift
//  Alidade
//
//  Created by Dmitry Duleba on 8/9/18.
//

import Foundation
import UserNotifications

@available(iOS 10.0, *)
public protocol UserNotificationsService {

  func handleUNResponse(response: UNNotificationResponse, from center: UNUserNotificationCenter,
                        with completion: @escaping VoidHandler) -> Bool

  func handleUNWillPresent(notification: UNNotification, from center: UNUserNotificationCenter,
                           with completion: @escaping NotificationPresentationOptionsHandler) -> Bool
}

@available(iOS 10.0, *)
public extension UserNotificationsService {

  public func handleUNResponse(response: UNNotificationResponse, from center: UNUserNotificationCenter,
                               with completion: @escaping VoidHandler) -> Bool {
    return false
  }

  func handleUNWillPresent(notification: UNNotification, from center: UNUserNotificationCenter,
                           with completion: @escaping NotificationPresentationOptionsHandler) -> Bool {
    return false
  }
}
