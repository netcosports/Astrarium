//
//  AppService.swift
//  Astrarium
//
//  Created by Dmitry Duleba on 5/23/18.
//
import UIKit
import UserNotifications

public protocol AppService: ServiceInitiable {

  /// will call setup in willFinishLaunch if 'true',
  /// otherwise in didFinishLaunch
  var shouldSetupEarly: Bool { get }

  func setup(with launchOptions: LaunchOptions)

  func applicationWillFinishLaunch(with options: LaunchOptions?)

  func applicationDidFinishLaunch(with options: LaunchOptions?)

  func applicationDidBecomeActive()

  func applicationWillResignActive()

  func applicationWillEnterForeground()

  func applicationDidEnterBackground()

  func applicationWillTerminate()

  func appDidReceiveMemoryWarning()

  func appSignificantTimeChange()


}

// MARK: - Defaults

public extension AppService {

  public var shouldSetupEarly: Bool { return false }

  public func applicationWillFinishLaunch(with options: LaunchOptions?) {}

  public func applicationDidFinishLaunch(with options: LaunchOptions?) {}

  public func applicationDidBecomeActive() {}

  public func applicationWillResignActive() {}

  public func applicationWillEnterForeground() {}

  public func applicationDidEnterBackground() {}

  public func applicationWillTerminate() {}

  public func appDidReceiveMemoryWarning() {}

  public func appSignificantTimeChange() {}

  // MARK: - App Orientation

  public func appSupportedInterfaceOrientations(for window: UIWindow?) -> UIInterfaceOrientationMask {
    return UIInterfaceOrientationMask(rawValue: 0)
  }

  // MARK: - URLs
  
  public func appOpen(url: URL, sourceApplication: String?, annotation: Any?) -> Bool {
    return false
  }
  
  public func appOpen(url: URL, options: OpenURLOptions = [:]) -> Bool {
    return false
  }
  
  // MARK: - Status bar
  // MARK: Orientation
  
  public func application(_ application: UIApplication,
                          willChangeStatusBarOrientation newStatusBarOrientation: UIInterfaceOrientation,
                          duration: TimeInterval) {

  }

  public func application(_ application: UIApplication,
                        didChangeStatusBarOrientation oldStatusBarOrientation: UIInterfaceOrientation) {

  }

  // MARK: Frame

  public func application(_ application: UIApplication,
                        willChangeStatusBarFrame newStatusBarFrame: CGRect) {

  }

  public func application(_ application: UIApplication,
                        didChangeStatusBarFrame oldStatusBarFrame: CGRect) {

  }

  // MARK: - Notifications

  //swiftlint:disable:next line_length
  @available(iOS, introduced: 8.0, deprecated: 10.0, message: "Use UserNotifications Framework's -[UNUserNotificationCenter requestAuthorizationWithOptions:completionHandler:]")
  public func application(_ application: UIApplication,
                        didRegister notificationSettings: UIUserNotificationSettings) {

  }

  public func application(_ application: UIApplication,
                        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {

  }

  public func application(_ application: UIApplication,
                        didFailToRegisterForRemoteNotificationsWithError error: Error) {

  }

  //swiftlint:disable:next line_length
  @available(iOS, introduced: 3.0, deprecated: 10.0, message: "Use UserNotifications Framework's -[UNUserNotificationCenterDelegate willPresentNotification:withCompletionHandler:] or -[UNUserNotificationCenterDelegate didReceiveNotificationResponse:withCompletionHandler:] for user visible notifications and -[UIApplicationDelegate application:didReceiveRemoteNotification:fetchCompletionHandler:] for silent remote notifications")
  public func application(_ application: UIApplication,
                        didReceiveRemoteNotification userInfo: UserInfo) {

  }

  //swiftlint:disable:next line_length
  @available(iOS, introduced: 4.0, deprecated: 10.0, message: "Use UserNotifications Framework's -[UNUserNotificationCenterDelegate willPresentNotification:withCompletionHandler:] or -[UNUserNotificationCenterDelegate didReceiveNotificationResponse:withCompletionHandler:]")
  public func application(_ application: UIApplication,
                        didReceive notification: UILocalNotification) {

  }

  //swiftlint:disable:next line_length
  @available(iOS, introduced: 8.0, deprecated: 10.0, message: "Use UserNotifications Framework's -[UNUserNotificationCenterDelegate didReceiveNotificationResponse:withCompletionHandler:]")
  public func application(_ application: UIApplication,
                        handleActionWithIdentifier identifier: String?,
                        for notification: UILocalNotification,
                        completionHandler: @escaping VoidHandler) {

  }

  //swiftlint:disable:next line_length
  @available(iOS, introduced: 9.0, deprecated: 10.0, message: "Use UserNotifications Framework's -[UNUserNotificationCenterDelegate didReceiveNotificationResponse:withCompletionHandler:]")
  public func application(_ application: UIApplication,
                        handleActionWithIdentifier identifier: String?,
                        forRemoteNotification userInfo: UserInfo,
                        withResponseInfo responseInfo: UserInfo,
                        completionHandler: @escaping VoidHandler) {

  }

  //swiftlint:disable:next line_length
  @available(iOS, introduced: 8.0, deprecated: 10.0, message: "Use UserNotifications Framework's -[UNUserNotificationCenterDelegate didReceiveNotificationResponse:withCompletionHandler:]")
  public func application(_ application: UIApplication,
                        handleActionWithIdentifier identifier: String?,
                        forRemoteNotification userInfo: UserInfo,
                        completionHandler: @escaping VoidHandler) {

  }

  //swiftlint:disable:next line_length
  @available(iOS, introduced: 9.0, deprecated: 10.0, message: "Use UserNotifications Framework's -[UNUserNotificationCenterDelegate didReceiveNotificationResponse:withCompletionHandler:]")
  public func application(_ application: UIApplication,
                        handleActionWithIdentifier identifier: String?,
                        for notification: UILocalNotification,
                        withResponseInfo responseInfo: UserInfo,
                        completionHandler: @escaping VoidHandler) {

  }

  // MARK: - Background

  public func application(_ application: UIApplication,
                        didReceiveRemoteNotification userInfo: UserInfo,
                        fetchCompletionHandler completionHandler: @escaping BackgroundFetchResultHandler) {

  }

  public func application(_ application: UIApplication,
                        performFetchWithCompletionHandler completionHandler: @escaping BackgroundFetchResultHandler) {

  }

  public func application(_ application: UIApplication,
                        handleEventsForBackgroundURLSession identifier: String,
                        completionHandler: @escaping VoidHandler) {

  }

  // MARK: - Shorcuts

  public func application(_ application: UIApplication,
                        performActionFor shortcutItem: UIApplicationShortcutItem,
                        completionHandler: @escaping BoolHandler) {

  }

  // MARK: - WatchKit

  public func application(_ application: UIApplication,
                        handleWatchKitExtensionRequest userInfo: UserInfo?,
                        reply: @escaping UserInfoHandler) {

  }

  // MARK: - HealthKit

  @available(iOS 9.0, *)
  public func applicationShouldRequestHealthAuthorization(_ application: UIApplication) {

  }

  // MARK: - Protected Data

  public func applicationProtectedDataWillBecomeUnavailable(_ application: UIApplication) {

  }

  public func applicationProtectedDataDidBecomeAvailable(_ application: UIApplication) {

  }

  // MARK: - Extensions

  //swiftlint:disable line_length
  public func application(_ application: UIApplication,
                        shouldAllowExtensionPointIdentifier extensionPointIdentifier: UIApplicationExtensionPointIdentifier) -> Bool {
    return true
  }
  //swiftlint:enable line_length

  // MARK: - Restoration

  public func application(_ application: UIApplication,
                        viewControllerWithRestorationIdentifierPath identifierComponents: [Any],
                        coder: NSCoder) -> UIViewController? {
    return nil
  }

  public func application(_ application: UIApplication, shouldSaveApplicationState coder: NSCoder) -> Bool {
    return false
  }

  public func application(_ application: UIApplication, shouldRestoreApplicationState coder: NSCoder) -> Bool {
    return false
  }

  public func application(_ application: UIApplication, willEncodeRestorableStateWith coder: NSCoder) {

  }

  public func application(_ application: UIApplication, didDecodeRestorableStateWith coder: NSCoder) {

  }

  // MARK: - User Activity

  public func application(_ application: UIApplication,
                        willContinueUserActivityWithType userActivityType: String) -> Bool {
    return false
  }

  public func application(_ application: UIApplication,
                        continue userActivity: NSUserActivity,
                        restorationHandler: @escaping RestorationHandler) -> Bool {
    return false
  }

  public func application(_ application: UIApplication,
                        didFailToContinueUserActivityWithType userActivityType: String,
                        error: Error) {

  }

  public func application(_ application: UIApplication,
                        didUpdate userActivity: NSUserActivity) {

  }

//  @available(iOS 10.0, *)
//  public func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse,
//                              withCompletionHandler completionHandler: @escaping VoidHandler) { }
//
//  @available(iOS 10.0, *)
//  //swiftlint:disable line_length
//  public func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification,
//                              withCompletionHandler completionHandler: @escaping NotificationPresentationOptionsHandler) { }
//  //swiftlint:enable line_length
}
