//
//  AppService.swift
//  Astrarium
//
//  Created by Dmitry Duleba on 5/23/18.
//
import UIKit

public protocol AppService: ServiceInitiable {

  /// will call setup in willFinishLaunch if 'true',
  /// otherwise in didFinishLaunch
  var shouldSetupEarly: Bool { get }

  func setup(with launchOptions: LaunchOptions)

  func appDidBecomeActive()

  func appWillResignActive()

  func appWillEnterForeground()

  func appDidEnterBackground()

  func appWillTerminate()

  func appDidReceiveMemoryWarning()

  func appSignificantTimeChange()

  // MARK: - App Orientation

  func appInterfaceOrientationMask(for window: UIWindow?) -> UIInterfaceOrientationMask

  // MARK: - URLs

  func shouldAppOpen(url: URL, options: OpenURLOptions) -> Bool

  // MARK: - Status bar
  // MARK: Orientation

  func appWillChangeStatusBarOrientation(to new: UIInterfaceOrientation, duration: TimeInterval)

  func appDidChangeStatusBarOrientation(from old: UIInterfaceOrientation)

  // MARK: Frame

  func appWillChangeStatusBarFrame(to new: CGRect)

  func appDidChangeStatusBarFrame(from old: CGRect)

  // MARK: - Notifications

  //swiftlint:disable line_length

  @available(iOS, introduced: 8.0, deprecated: 10.0, message: "Use UserNotifications Framework's -[UNUserNotificationCenter requestAuthorizationWithOptions:completionHandler:]")
  func appDidRegister(notificationSettings: UIUserNotificationSettings)

  func appDidRegisterForRemoteNotifications(with deviceToken: Data)

  func appDidFailToRegisterForRemoteNotifications(with error: Error)

  @available(iOS, deprecated: 10.0, message: "Use UserNotifications Framework's -[UNUserNotificationCenterDelegate willPresentNotification:withCompletionHandler:] or -[UNUserNotificationCenterDelegate didReceiveNotificationResponse:withCompletionHandler:] for user visible notifications and -[UIApplicationDelegate application:didReceiveRemoteNotification:fetchCompletionHandler:] for silent remote notifications")
  func appDidReceive(_ notification: Notification)

  // MARK: - Notification.Actions

  @available(iOS, deprecated: 10.0, message: "Use UserNotifications Framework's -[UNUserNotificationCenterDelegate didReceiveNotificationResponse:withCompletionHandler:]")
  func appHandleAction(with identifier: String?, for notification: Notification,
                       responseInfo: ResponseInfo?, completionHandler: @escaping VoidHandler)

  // MARK: - Background

  func appReadyFetchDataForRemoteNotification(with userInfo: UserInfo, fetchHandler: @escaping BackgroundFetchResultHandler)
  //swiftlint:enable line_length

  func appPerformFetch(with completionHandler: @escaping BackgroundFetchResultHandler)

  func appHandleEventsForBackgroundURLSession(with identifier: String, completionHandler: @escaping VoidHandler)

  // MARK: - Shorcuts

  func appPerformAction(for shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping BoolHandler)

  // MARK: - WatchKit

  func appHandleWatchKitExtensionRequest(with userInfo: UserInfo?, reply: @escaping UserInfoHandler)

  // MARK: - HealthKit

  @available(iOS 9.0, *)
  func appShouldRequestHealthAuthorization()

  // MARK: - Protected Data

  func appProtectedDataWillBecomeUnavailable()

  func appProtectedDataDidBecomeAvailable()

  // MARK: - Extensions

  func appShouldAllow(extensionPointIdentifier: UIApplicationExtensionPointIdentifier) -> Bool

  // MARK: - Restoration

  func appViewController(with restorationIdentifierComponents: [Any], coder: NSCoder) -> UIViewController?

  func appShouldSaveApplicationState(coder: NSCoder) -> Bool

  func appShouldRestoreApplicationState(coder: NSCoder) -> Bool

  func appWillEncodeRestorableState(with coder: NSCoder)

  func appDidDecodeRestorableState(with coder: NSCoder)

  // MARK: - User Activity

  func appWillContinueUserActivity(with userActivityType: String) -> Bool

  func appContinue(userActivity: NSUserActivity, restorationHandler: @escaping RestorationHandler) -> Bool

  func appDidFailToContinueUserActivity(with userActivityType: String, error: Error)

  func appDidUpdate(userActivity: NSUserActivity)

}

// MARK: - Defaults

public extension AppService {

  var shouldSetupEarly: Bool { return false }

  func appDidBecomeActive() { }

  func appWillResignActive() { }

  func appWillEnterForeground() { }

  func appDidEnterBackground() { }

  func appWillTerminate() { }

  func appDidReceiveMemoryWarning() { }

  func appSignificantTimeChange() { }

  // MARK: - App Orientation

  func appInterfaceOrientationMask(for window: UIWindow?) -> UIInterfaceOrientationMask {
    return UIInterfaceOrientationMask(rawValue: 0)
  }

  // MARK: - URLs

  func shouldAppOpen(url: URL, options: OpenURLOptions = [:]) -> Bool {
    return true
  }

  // MARK: - Status bar
  // MARK: Orientation

  func appWillChangeStatusBarOrientation(to new: UIInterfaceOrientation, duration: TimeInterval) { }

  func appDidChangeStatusBarOrientation(from old: UIInterfaceOrientation) { }

  // MARK: Frame

  func appWillChangeStatusBarFrame(to new: CGRect) {
  }

  func appDidChangeStatusBarFrame(from old: CGRect) { }

  // MARK: - Notifications

  //swiftlint:disable line_length
  @available(iOS, introduced: 8.0, deprecated: 10.0, message: "Use UserNotifications Framework's -[UNUserNotificationCenter requestAuthorizationWithOptions:completionHandler:]")
  func appDidRegister(notificationSettings: UIUserNotificationSettings) { }

  func appDidRegisterForRemoteNotifications(with deviceToken: Data) { }

  func appDidFailToRegisterForRemoteNotifications(with error: Error) { }

  @available(iOS, introduced: 3.0, deprecated: 10.0, message: "Use UserNotifications Framework's -[UNUserNotificationCenterDelegate willPresentNotification:withCompletionHandler:] or -[UNUserNotificationCenterDelegate didReceiveNotificationResponse:withCompletionHandler:] for user visible notifications and -[UIApplicationDelegate application:didReceiveRemoteNotification:fetchCompletionHandler:] for silent remote notifications")
  func appDidReceive(_ notification: Notification) { }

  // MARK: - Notification.Actions

  @available(iOS, introduced: 9.0, deprecated: 10.0, message: "Use UserNotifications Framework's -[UNUserNotificationCenterDelegate didReceiveNotificationResponse:withCompletionHandler:]")
  func appHandleAction(with identifier: String?, for notification: Notification,
                       with responseInfo: ResponseInfo?, completionHandler: @escaping VoidHandler) { }
  //swiftlint:enable line_length

  // MARK: - Background

  func appReadyFetchDataForRemoteNotification(with userInfo: UserInfo,
                                              fetchHandler: @escaping BackgroundFetchResultHandler) { }

  func appPerformFetch(with completionHandler: @escaping BackgroundFetchResultHandler) { }

  func appHandleEventsForBackgroundURLSession(with identifier: String,
                                              completionHandler: @escaping VoidHandler) { }

  // MARK: - Shorcuts

  func appPerformAction(for shortcutItem: UIApplicationShortcutItem,
                        completionHandler: @escaping BoolHandler) { }

  // MARK: - WatchKit

  func appHandleWatchKitExtensionRequest(with userInfo: UserInfo?,
                                         reply: @escaping UserInfoHandler) { }

  // MARK: - HealthKit

  @available(iOS 9.0, *)
  func appShouldRequestHealthAuthorization() { }

  // MARK: - Protected Data

  func appProtectedDataWillBecomeUnavailable() { }

  func appProtectedDataDidBecomeAvailable() { }

  // MARK: - Extensions

  func appShouldAllow(extensionPointIdentifier: UIApplicationExtensionPointIdentifier) -> Bool {
    return true
  }

  // MARK: - Restoration

  func appViewController(with restorationIdentifierComponents: [Any], coder: NSCoder) -> UIViewController? {
    return nil
  }

  func appShouldSaveApplicationState(coder: NSCoder) -> Bool {
    return false
  }

  func appShouldRestoreApplicationState(coder: NSCoder) -> Bool {
    return false
  }

  func appWillEncodeRestorableState(with coder: NSCoder) { }

  func appDidDecodeRestorableState(with coder: NSCoder) { }

  // MARK: - User Activity

  func appWillContinueUserActivity(with userActivityType: String) -> Bool {
    return false
  }

  func appContinue(userActivity: NSUserActivity, restorationHandler: @escaping RestorationHandler) -> Bool {
    return false
  }

  func appDidFailToContinueUserActivity(with userActivityType: String, error: Error) { }

  func appDidUpdate(userActivity: NSUserActivity) { }
}
