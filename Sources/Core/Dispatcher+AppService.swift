//
//  Dispatcher+UIApplicationDelegate.swift
//  Astrarium
//
//  Created by Dmitry Duleba on 5/31/18.
//

import Foundation

extension Dispatcher: AppService {

  public func appWillFinishLaunch(with options: LaunchOptions?) {
    earlyServices
      .forEach { $0.setup(with: options ?? [:]) }
  }

  public func appDidFinishLaunch(with options: LaunchOptions?) {
    lateServices
      .forEach { $0.setup(with: options ?? [:]) }
  }

  public func appDidBecomeActive() {
    allServices.forEach { $0.appDidBecomeActive() }
  }

  public func appWillResignActive() {
    allServices.forEach { $0.appWillResignActive() }
  }

  public func appWillEnterForeground() {
    allServices.forEach { $0.appWillEnterForeground() }
  }

  public func appDidEnterBackground() {
    allServices.forEach { $0.appDidEnterBackground() }
  }

  public func appWillTerminate() {
    allServices.forEach { $0.appWillTerminate() }
  }

  public func appDidReceiveMemoryWarning() {
    allServices.forEach { $0.appDidReceiveMemoryWarning() }
  }

  public func appSignificantTimeChange() {
    allServices.forEach { $0.appSignificantTimeChange() }
  }

  // MARK: - App Orientation

  public func appInterfaceOrientationMask(for window: UIWindow?) -> UIInterfaceOrientationMask {
    for service in allServices {
      let mask = service.appInterfaceOrientationMask(for: window)
      if mask.rawValue != 0 {
        return mask
      }
    }
    return UIInterfaceOrientationMask(rawValue: 0)
  }

  // MARK: - URLs

  public func shouldAppOpen(url: URL, options: OpenURLOptions = [:]) -> Bool {
    for service in allServices {
      if service.shouldAppOpen(url: url, options: options) {
        return false
      }
    }
    return true
  }

  // MARK: - Status bar
  // MARK: Orientation

  public func appWillChangeStatusBarOrientation(to new: UIInterfaceOrientation, duration: TimeInterval) {
    allServices.forEach { $0.appWillChangeStatusBarOrientation(to: new, duration: duration) }
  }

  public func appDidChangeStatusBarOrientation(from old: UIInterfaceOrientation) {
    allServices.forEach { $0.appDidChangeStatusBarOrientation(from: old) }
  }

  // MARK: Frame

  public func appWillChangeStatusBarFrame(to new: CGRect) {
    allServices.forEach { $0.appWillChangeStatusBarFrame(to: new) }
  }

  public func appDidChangeStatusBarFrame(from old: CGRect) {
    allServices.forEach { $0.appDidChangeStatusBarFrame(from: old) }
  }

  // MARK: - Notifications

  //swiftlint:disable line_length
  @available(iOS, introduced: 8.0, deprecated: 10.0, message: "Use UserNotifications Framework's -[UNUserNotificationCenter requestAuthorizationWithOptions:completionHandler:]")
  public func appDidRegister(notificationSettings: UIUserNotificationSettings) {
    allServices.forEach { $0.appDidRegister(notificationSettings: notificationSettings) }
  }

  public func appDidRegisterForRemoteNotifications(with deviceToken: Data) {
    allServices.forEach { $0.appDidRegisterForRemoteNotifications(with: deviceToken) }
  }

  public func appDidFailToRegisterForRemoteNotifications(with error: Error) {
    allServices.forEach { $0.appDidFailToRegisterForRemoteNotifications(with: error) }
  }

  @available(iOS, deprecated: 10.0, message: "Use UserNotifications Framework's -[UNUserNotificationCenterDelegate willPresentNotification:withCompletionHandler:] or -[UNUserNotificationCenterDelegate didReceiveNotificationResponse:withCompletionHandler:] for user visible notifications and -[UIApplicationDelegate application:didReceiveRemoteNotification:fetchCompletionHandler:] for silent remote notifications")
  public func appDidReceive(_ notification: Notification) {
    allServices.forEach { $0.appDidReceive(notification) }
  }

  // MARK: - Notification.Actions

  @available(iOS, deprecated: 10.0, message: "Use UserNotifications Framework")
  public func appHandleAction(with identifier: String?, for notification: Notification,
                              responseInfo: ResponseInfo?, completionHandler: @escaping VoidHandler) {
    allServices.forEach { $0.appHandleAction(with: identifier, for: notification,
                                             responseInfo: responseInfo, completionHandler: completionHandler) }
  }

  //swiftlint:enable line_length

  // MARK: - Background

  public func appReadyFetchDataForRemoteNotification(with userInfo: UserInfo,
                                                     fetchHandler: @escaping BackgroundFetchResultHandler) {
    allServices.forEach { $0.appReadyFetchDataForRemoteNotification(with: userInfo,
                                                                    fetchHandler: fetchHandler) }
  }

  public func appPerformFetch(with completionHandler: @escaping BackgroundFetchResultHandler) {
    allServices.forEach { $0.appPerformFetch(with: completionHandler) }
  }

  public func appHandleEventsForBackgroundURLSession(with identifier: String,
                                                     completionHandler: @escaping VoidHandler) {
    allServices.forEach { $0.appHandleEventsForBackgroundURLSession(with: identifier,
                                                                    completionHandler: completionHandler) }
  }

  // MARK: - Shorcuts

  public func appPerformAction(for shortcutItem: UIApplicationShortcutItem,
                               completionHandler: @escaping BoolHandler) {
    allServices.forEach { $0.appPerformAction(for: shortcutItem, completionHandler: completionHandler) }
  }

  // MARK: - WatchKit

  public func appHandleWatchKitExtensionRequest(with userInfo: UserInfo?,
                                                reply: @escaping UserInfoHandler) {
    allServices.forEach { $0.appHandleWatchKitExtensionRequest(with: userInfo, reply: reply) }
  }

  // MARK: - HealthKit

  @available(iOS 9.0, *)
  public func appShouldRequestHealthAuthorization() {
    allServices.forEach { $0.appShouldRequestHealthAuthorization() }
  }

  // MARK: - Protected Data

  public func appProtectedDataWillBecomeUnavailable() {
    allServices.forEach { $0.appProtectedDataWillBecomeUnavailable() }
  }

  public func appProtectedDataDidBecomeAvailable() {
    allServices.forEach { $0.appProtectedDataDidBecomeAvailable() }
  }

  // MARK: - Extensions

  public func appShouldAllow(extensionPointIdentifier: UIApplicationExtensionPointIdentifier) -> Bool {
    for service in allServices {
      if !service.appShouldAllow(extensionPointIdentifier: extensionPointIdentifier) {
        return false
      }
    }
    return true
  }

  // MARK: - Restoration

  public func appViewController(with restorationIdentifierComponents: [Any], coder: NSCoder) -> UIViewController? {
    for service in allServices {
      if let viewController = service.appViewController(with: restorationIdentifierComponents, coder: coder) {
        return viewController
      }
    }
    return nil
  }

  public func appShouldSaveApplicationState(coder: NSCoder) -> Bool {
    for service in allServices {
      if service.appShouldSaveApplicationState(coder: coder) {
        return true
      }
    }
    return false
  }

  public func appShouldRestoreApplicationState(coder: NSCoder) -> Bool {
    for service in allServices {
      if service.appShouldRestoreApplicationState(coder: coder) {
        return true
      }
    }
    return false
  }

  public func appWillEncodeRestorableState(with coder: NSCoder) {
    allServices.forEach { $0.appWillEncodeRestorableState(with: coder) }
  }

  public func appDidDecodeRestorableState(with coder: NSCoder) {
    allServices.forEach { $0.appDidDecodeRestorableState(with: coder) }
  }

  // MARK: - User Activity

  public func appWillContinueUserActivity(with userActivityType: String) -> Bool {
    for service in allServices {
      if service.appWillContinueUserActivity(with: userActivityType) {
        return true
      }
    }
    return false
  }

  public func appContinue(userActivity: NSUserActivity, restorationHandler: @escaping RestorationHandler) -> Bool {
    for service in allServices {
      if service.appContinue(userActivity: userActivity, restorationHandler: restorationHandler) {
        return true
      }
    }
    return false
  }

  public func appDidFailToContinueUserActivity(with userActivityType: String, error: Error) {
    allServices.forEach { $0.appDidFailToContinueUserActivity(with: userActivityType, error: error) }
  }

  public func appDidUpdate(userActivity: NSUserActivity) {
    allServices.forEach { $0.appDidUpdate(userActivity: userActivity) }
  }
}
