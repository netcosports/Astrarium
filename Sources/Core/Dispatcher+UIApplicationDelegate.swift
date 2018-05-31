//
//  Dispatcher+UIApplicationDelegate.swift
//  Astrarium
//
//  Created by Dmitry Duleba on 5/31/18.
//

import Foundation

extension Dispatcher: UIApplicationDelegate {

  // MARK: - Application Lifecycle

  @discardableResult
  public func application(_ application: UIApplication,
                          willFinishLaunchingWithOptions launchOptions: LaunchOptions? = nil) -> Bool {
    allServices.filter { $0.shouldSetupEarly }
      .forEach { $0.setup(with: launchOptions ?? [:]) }
    allServices.forEach { $0.applicationWillFinishLaunch(with: launchOptions) }
    return true
  }

  @discardableResult
  public func application(_ application: UIApplication,
                          didFinishLaunchingWithOptions launchOptions: LaunchOptions?) -> Bool {
    allServices.filter { !$0.shouldSetupEarly }
      .forEach { $0.setup(with: launchOptions ?? [:]) }
    allServices.forEach { $0.applicationDidFinishLaunch(with: launchOptions) }
    return true
  }

  public func applicationDidBecomeActive(_ application: UIApplication) {
    allServices.forEach { $0.applicationDidBecomeActive() }
  }

  public func applicationWillResignActive(_ application: UIApplication) {
    allServices.forEach { $0.applicationWillResignActive() }
  }

  public func applicationWillEnterForeground(_ application: UIApplication) {
    allServices.forEach { $0.applicationWillEnterForeground() }
  }

  public func applicationDidEnterBackground(_ application: UIApplication) {
    allServices.forEach { $0.applicationDidEnterBackground() }
  }

  public func applicationWillTerminate(_ application: UIApplication) {
    allServices.forEach { $0.applicationWillTerminate() }
  }

  public func applicationDidReceiveMemoryWarning(_ application: UIApplication) {
    allServices.forEach { $0.appDidReceiveMemoryWarning() }
  }

  public func applicationSignificantTimeChange(_ application: UIApplication) {
    allServices.forEach { $0.appSignificantTimeChange() }
  }

  // MARK: - App Orientation

  public func application(_ application: UIApplication,
                          supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
    for service in allServices {
      let mask = service.appSupportedInterfaceOrientations(for: window)
      if mask.rawValue != 0 {
        return mask
      }
    }
    return UIInterfaceOrientationMask(rawValue: 0)
  }

  // MARK: - URLs

  public func application(_ application: UIApplication,
                          handleOpen url: URL) -> Bool {
    return self.application(application, open: url, options: [:])
  }

  public func application(_ application: UIApplication,
                          open url: URL,
                          sourceApplication: String?,
                          annotation: Any?) -> Bool {
    var options = OpenURLOptions()
    options[.sourceApplication] = sourceApplication
    options[.annotation] = annotation
    return self.application(application, open: url, options: options)
  }

  public func application(_ app: UIApplication,
                          open url: URL,
                          options: OpenURLOptions = [:]) -> Bool {
    for service in allServices {
      if service.appOpen(url: url, options: options) {
        return true
      }
    }
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
  @available(iOS, introduced: 3.0, deprecated: 10.0)
  public func application(_ application: UIApplication,
                          didReceiveRemoteNotification userInfo: UserInfo) {

  }

  //swiftlint:disable:next line_length
  @available(iOS, introduced: 4.0, deprecated: 10.0)
  public func application(_ application: UIApplication,
                          didReceive notification: UILocalNotification) {

  }

  //swiftlint:disable:next line_length
  @available(iOS, introduced: 8.0, deprecated: 10.0)
  public func application(_ application: UIApplication,
                          handleActionWithIdentifier identifier: String?,
                          for notification: UILocalNotification,
                          completionHandler: @escaping VoidHandler) {

  }

  //swiftlint:disable:next line_length
  @available(iOS, introduced: 9.0, deprecated: 10.0)
  public func application(_ application: UIApplication,
                          handleActionWithIdentifier identifier: String?,
                          forRemoteNotification userInfo: UserInfo,
                          withResponseInfo responseInfo: UserInfo,
                          completionHandler: @escaping VoidHandler) {

  }

  //swiftlint:disable:next line_length
  @available(iOS, introduced: 8.0, deprecated: 10.0)
  public func application(_ application: UIApplication,
                          handleActionWithIdentifier identifier: String?,
                          forRemoteNotification userInfo: UserInfo,
                          completionHandler: @escaping VoidHandler) {

  }

  //swiftlint:disable:next line_length
  @available(iOS, introduced: 9.0, deprecated: 10.0)
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
}
