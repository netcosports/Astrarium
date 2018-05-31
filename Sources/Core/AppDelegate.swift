//
//  AppDelegate.swift
//  Astrarium
//
//  Created by Dmitry Duleba on 5/23/18.
//

import UIKit

#if canImport(UserNotifications)
import UserNotifications
#endif

open class AppDelegate: UIResponder, UIApplicationDelegate {

  private(set) lazy var dispatcher: Dispatcher = {
    let dispatcher = Dispatcher(services: services)
    type(of: dispatcher).register(shared: dispatcher)
    return dispatcher
  }()

  open var services: [ServiceIds?] { return [] }

  public override init() {
    super.init()
    setup()
  }

  func setup() {
    if #available(iOS 10.0, *) {
      if let delegate = self as? UNUserNotificationCenterDelegate {
        UNUserNotificationCenter.current().delegate = delegate
        print("Bound User Notifications delegate")
      } else {
        print("Not bound User Notifications delegate")
      }
    }
  }

  // MARK: - Application Lifecycle -

  open func application(_ application: UIApplication,
                        willFinishLaunchingWithOptions launchOptions: LaunchOptions? = nil) -> Bool {
    dispatcher.application(application, willFinishLaunchingWithOptions: launchOptions)
    return true
  }

  open func application(_ application: UIApplication,
                        didFinishLaunchingWithOptions launchOptions: LaunchOptions? = nil) -> Bool {
    dispatcher.application(application, didFinishLaunchingWithOptions: launchOptions)
    return true
  }

  open func applicationDidBecomeActive(_ application: UIApplication) {
    dispatcher.applicationDidBecomeActive(application)
  }

  open func applicationWillResignActive(_ application: UIApplication) {
    dispatcher.applicationWillResignActive(application)
  }

  open func applicationDidEnterBackground(_ application: UIApplication) {
    dispatcher.applicationDidEnterBackground(application)
  }

  open func applicationWillEnterForeground(_ application: UIApplication) {
    dispatcher.applicationWillEnterForeground(application)
  }

  open func applicationWillTerminate(_ application: UIApplication) {
    dispatcher.applicationWillTerminate(application)
  }

  open func applicationDidReceiveMemoryWarning(_ application: UIApplication) {
    dispatcher.applicationDidReceiveMemoryWarning(application)
  }

  open func applicationSignificantTimeChange(_ application: UIApplication) {
    dispatcher.applicationSignificantTimeChange(application)
  }

  // MARK: - App Orientation

  open func application(_ application: UIApplication,
                        supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
    let result = dispatcher.application(application, supportedInterfaceOrientationsFor: window)
    if result.rawValue != 0 {
      return result
    }

    guard let plistPath = Bundle.main.path(forResource: "Info", ofType: "plist"),
      let plist = NSDictionary(contentsOfFile: plistPath),
      let orientations = plist.value(forKey: "UISupportedInterfaceOrientations") as? [String] else {
        return UIDevice.current.userInterfaceIdiom == .pad ? .all : .allButUpsideDown
    }

    var mask = UIInterfaceOrientationMask()
    orientations.forEach {
      print($0)
      switch $0 {
      case "UIInterfaceOrientationPortrait": mask.insert(.portrait)
      case "UIInterfaceOrientationPortraitUpsideDown": mask.insert(.portraitUpsideDown)
      case "UIInterfaceOrientationLandscapeLeft": mask.insert(.landscapeLeft)
      case "UIInterfaceOrientationLandscapeRight": mask.insert(.landscapeRight)
      default: break
      }
    }
    return mask
  }

  // MARK: - URLs

  @available(iOS, introduced: 2.0, deprecated: 9.0, message: "Please use application:openURL:options:")
  open func application(_ application: UIApplication,
                        handleOpen url: URL) -> Bool {
    return false
  }

  @available(iOS, introduced: 4.2, deprecated: 9.0, message: "Please use application:openURL:options:")
  open func application(_ application: UIApplication,
                        open url: URL,
                        sourceApplication: String?,
                        annotation: Any?) -> Bool {
    return false
  }

  open func application(_ app: UIApplication,
                        open url: URL,
                        options: OpenURLOptions = [:]) -> Bool {
    if dispatcher.application(app, open: url, options: options) {
      return true
    }
    return false
  }

  // MARK: - Status bar
  // MARK: Orientation

  open func application(_ application: UIApplication,
                        willChangeStatusBarOrientation newStatusBarOrientation: UIInterfaceOrientation,
                        duration: TimeInterval) {

  }

  open func application(_ application: UIApplication,
                        didChangeStatusBarOrientation oldStatusBarOrientation: UIInterfaceOrientation) {

  }

  // MARK: Frame

  open func application(_ application: UIApplication,
                        willChangeStatusBarFrame newStatusBarFrame: CGRect) {

  }

  open func application(_ application: UIApplication,
                        didChangeStatusBarFrame oldStatusBarFrame: CGRect) {

  }

  // MARK: - Notifications

  //swiftlint:disable:next line_length
  @available(iOS, introduced: 8.0, deprecated: 10.0, message: "Use UserNotifications Framework's -[UNUserNotificationCenter requestAuthorizationWithOptions:completionHandler:]")
  open func application(_ application: UIApplication,
                        didRegister notificationSettings: UIUserNotificationSettings) {

  }

  open func application(_ application: UIApplication,
                        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {

  }

  open func application(_ application: UIApplication,
                        didFailToRegisterForRemoteNotificationsWithError error: Error) {

  }

  //swiftlint:disable:next line_length
  @available(iOS, introduced: 3.0, deprecated: 10.0, message: "Use UserNotifications Framework's -[UNUserNotificationCenterDelegate willPresentNotification:withCompletionHandler:] or -[UNUserNotificationCenterDelegate didReceiveNotificationResponse:withCompletionHandler:] for user visible notifications and -[UIApplicationDelegate application:didReceiveRemoteNotification:fetchCompletionHandler:] for silent remote notifications")
  open func application(_ application: UIApplication,
                        didReceiveRemoteNotification userInfo: UserInfo) {

  }

  //swiftlint:disable:next line_length
  @available(iOS, introduced: 4.0, deprecated: 10.0, message: "Use UserNotifications Framework's -[UNUserNotificationCenterDelegate willPresentNotification:withCompletionHandler:] or -[UNUserNotificationCenterDelegate didReceiveNotificationResponse:withCompletionHandler:]")
  open func application(_ application: UIApplication,
                        didReceive notification: UILocalNotification) {

  }

  //swiftlint:disable:next line_length
  @available(iOS, introduced: 8.0, deprecated: 10.0, message: "Use UserNotifications Framework's -[UNUserNotificationCenterDelegate didReceiveNotificationResponse:withCompletionHandler:]")
  open func application(_ application: UIApplication,
                        handleActionWithIdentifier identifier: String?,
                        for notification: UILocalNotification,
                        completionHandler: @escaping VoidHandler) {

  }

  //swiftlint:disable:next line_length
  @available(iOS, introduced: 9.0, deprecated: 10.0, message: "Use UserNotifications Framework's -[UNUserNotificationCenterDelegate didReceiveNotificationResponse:withCompletionHandler:]")
  open func application(_ application: UIApplication,
                        handleActionWithIdentifier identifier: String?,
                        forRemoteNotification userInfo: UserInfo,
                        withResponseInfo responseInfo: UserInfo,
                        completionHandler: @escaping VoidHandler) {

  }

  //swiftlint:disable:next line_length
  @available(iOS, introduced: 8.0, deprecated: 10.0, message: "Use UserNotifications Framework's -[UNUserNotificationCenterDelegate didReceiveNotificationResponse:withCompletionHandler:]")
  open func application(_ application: UIApplication,
                        handleActionWithIdentifier identifier: String?,
                        forRemoteNotification userInfo: UserInfo,
                        completionHandler: @escaping VoidHandler) {

  }

  //swiftlint:disable:next line_length
  @available(iOS, introduced: 9.0, deprecated: 10.0, message: "Use UserNotifications Framework's -[UNUserNotificationCenterDelegate didReceiveNotificationResponse:withCompletionHandler:]")
  open func application(_ application: UIApplication,
                        handleActionWithIdentifier identifier: String?,
                        for notification: UILocalNotification,
                        withResponseInfo responseInfo: UserInfo,
                        completionHandler: @escaping VoidHandler) {

  }

  // MARK: - Background

  open func application(_ application: UIApplication,
                        didReceiveRemoteNotification userInfo: UserInfo,
                        fetchCompletionHandler completionHandler: @escaping BackgroundFetchResultHandler) {

  }

  open func application(_ application: UIApplication,
                        performFetchWithCompletionHandler completionHandler: @escaping BackgroundFetchResultHandler) {

  }

  open func application(_ application: UIApplication,
                        handleEventsForBackgroundURLSession identifier: String,
                        completionHandler: @escaping VoidHandler) {

  }

  // MARK: - Shorcuts

  open func application(_ application: UIApplication,
                        performActionFor shortcutItem: UIApplicationShortcutItem,
                        completionHandler: @escaping BoolHandler) {

  }

  // MARK: - WatchKit

  open func application(_ application: UIApplication,
                        handleWatchKitExtensionRequest userInfo: UserInfo?,
                        reply: @escaping UserInfoHandler) {

  }

  // MARK: - HealthKit

  @available(iOS 9.0, *)
  open func applicationShouldRequestHealthAuthorization(_ application: UIApplication) {

  }

  // MARK: - Protected Data

  open func applicationProtectedDataWillBecomeUnavailable(_ application: UIApplication) {

  }

  open func applicationProtectedDataDidBecomeAvailable(_ application: UIApplication) {

  }

  // MARK: - Extensions

  //swiftlint:disable line_length
  open func application(_ application: UIApplication,
                        shouldAllowExtensionPointIdentifier extensionPointIdentifier: UIApplicationExtensionPointIdentifier) -> Bool {
    return true
  }
  //swiftlint:enable line_length

  // MARK: - Restoration

  open func application(_ application: UIApplication,
                        viewControllerWithRestorationIdentifierPath identifierComponents: [Any],
                        coder: NSCoder) -> UIViewController? {
    return nil
  }

  open func application(_ application: UIApplication, shouldSaveApplicationState coder: NSCoder) -> Bool {
    return false
  }

  open func application(_ application: UIApplication, shouldRestoreApplicationState coder: NSCoder) -> Bool {
    return false
  }

  open func application(_ application: UIApplication, willEncodeRestorableStateWith coder: NSCoder) {

  }

  open func application(_ application: UIApplication, didDecodeRestorableStateWith coder: NSCoder) {

  }

  // MARK: - User Activity

  open func application(_ application: UIApplication,
                        willContinueUserActivityWithType userActivityType: String) -> Bool {
    return false
  }

  open func application(_ application: UIApplication,
                        continue userActivity: NSUserActivity,
                        restorationHandler: @escaping RestorationHandler) -> Bool {
    return false
  }

  open func application(_ application: UIApplication,
                        didFailToContinueUserActivityWithType userActivityType: String,
                        error: Error) {

  }

  open func application(_ application: UIApplication,
                        didUpdate userActivity: NSUserActivity) {

  }
}
