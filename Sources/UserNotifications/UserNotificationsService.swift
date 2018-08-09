//
//  UserNotificationsService.swift
//  Astrarium
//
//  Created by Dmitry Duleba on 8/9/18.
//

import Foundation
import UserNotifications

@available(iOS 10.0, *)
public protocol UserNotificationsService {

  func handleUserNotificationsResponse(response: UNNotificationResponse, from center: UNUserNotificationCenter,
                                       with completion: @escaping VoidHandler) -> Bool

  func handleUserNotificationsWillPresent(notification: UNNotification, from center: UNUserNotificationCenter,
                                          with completion: @escaping NotificationPresentationOptionsHandler) -> Bool
}

@available(iOS 10.0, *)
public extension UserNotificationsService {

  public func handleUserNotificationsResponse(response: UNNotificationResponse, from center: UNUserNotificationCenter,
                                              with completion: @escaping VoidHandler) -> Bool {
    return false
  }

  func handleUserNotificationsWillPresent(notification: UNNotification, from center: UNUserNotificationCenter,
                                          with completion: @escaping NotificationPresentationOptionsHandler) -> Bool {
    return false
  }
}
