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
      }
    }
  }

  // MARK: - Application Lifecycle -

  open func application(_ application: UIApplication,
                        willFinishLaunchingWithOptions launchOptions: LaunchOptions? = nil) -> Bool {
    dispatcher.appWillFinishLaunch(with: launchOptions)
    return true
  }

  open func application(_ application: UIApplication,
                        didFinishLaunchingWithOptions launchOptions: LaunchOptions? = nil) -> Bool {
    dispatcher.appDidFinishLaunch(with: launchOptions)
    return true
  }

  open func applicationDidBecomeActive(_ application: UIApplication) {
    dispatcher.appDidBecomeActive()
  }

  open func applicationWillResignActive(_ application: UIApplication) {
    dispatcher.appWillResignActive()
  }

  open func applicationDidEnterBackground(_ application: UIApplication) {
    dispatcher.appDidEnterBackground()
  }

  open func applicationWillEnterForeground(_ application: UIApplication) {
    dispatcher.appWillEnterForeground()
  }

  open func applicationWillTerminate(_ application: UIApplication) {
    dispatcher.appWillTerminate()
  }

  open func applicationDidReceiveMemoryWarning(_ application: UIApplication) {
    dispatcher.appDidReceiveMemoryWarning()
  }

  open func applicationSignificantTimeChange(_ application: UIApplication) {
    dispatcher.appSignificantTimeChange()
  }

  // MARK: - App Orientation

  open func application(_ application: UIApplication,
                        supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
    let result = dispatcher.appInterfaceOrientationMask(for: window)
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
    return self.application(application, open: url, options: [:])
  }

  @available(iOS, introduced: 4.2, deprecated: 9.0, message: "Please use application:openURL:options:")
  open func application(_ application: UIApplication,
                        open url: URL,
                        sourceApplication: String?,
                        annotation: Any?) -> Bool {
    var options = OpenURLOptions()
    options[.sourceApplication] = sourceApplication
    options[.annotation] = annotation
    return self.application(application, open: url, options: options)
  }

  open func application(_ app: UIApplication,
                        open url: URL,
                        options: OpenURLOptions = [:]) -> Bool {
    if !dispatcher.shouldAppOpen(url: url, options: options) {
      return false
    }
    return true
  }

  // MARK: - Status bar
  // MARK: Orientation

  open func application(_ application: UIApplication,
                        willChangeStatusBarOrientation newStatusBarOrientation: UIInterfaceOrientation,
                        duration: TimeInterval) {
    dispatcher.appWillChangeStatusBarOrientation(to: newStatusBarOrientation, duration: duration)
  }

  open func application(_ application: UIApplication,
                        didChangeStatusBarOrientation oldStatusBarOrientation: UIInterfaceOrientation) {
    dispatcher.appDidChangeStatusBarOrientation(from: oldStatusBarOrientation)
  }

  // MARK: Frame

  open func application(_ application: UIApplication,
                        willChangeStatusBarFrame newStatusBarFrame: CGRect) {
    dispatcher.appWillChangeStatusBarFrame(to: newStatusBarFrame)
  }

  open func application(_ application: UIApplication,
                        didChangeStatusBarFrame oldStatusBarFrame: CGRect) {
    dispatcher.appDidChangeStatusBarFrame(from: oldStatusBarFrame)
  }

  // MARK: - Notifications

  //swiftlint:disable:next line_length
  @available(iOS, introduced: 8.0, deprecated: 10.0, message: "Use UserNotifications Framework's -[UNUserNotificationCenter requestAuthorizationWithOptions:completionHandler:]")
  open func application(_ application: UIApplication,
                        didRegister notificationSettings: UIUserNotificationSettings) {
    dispatcher.appDidRegister(notificationSettings: notificationSettings)
  }

  open func application(_ application: UIApplication,
                        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    dispatcher.appDidRegisterForRemoteNotifications(with: deviceToken)
  }

  open func application(_ application: UIApplication,
                        didFailToRegisterForRemoteNotificationsWithError error: Error) {
    dispatcher.appDidFailToRegisterForRemoteNotifications(with: error)
  }

  //swiftlint:disable:next line_length
  @available(iOS, introduced: 3.0, deprecated: 10.0, message: "Use UserNotifications Framework's -[UNUserNotificationCenterDelegate willPresentNotification:withCompletionHandler:] or -[UNUserNotificationCenterDelegate didReceiveNotificationResponse:withCompletionHandler:] for user visible notifications and -[UIApplicationDelegate application:didReceiveRemoteNotification:fetchCompletionHandler:] for silent remote notifications")
  open func application(_ application: UIApplication,
                        didReceiveRemoteNotification userInfo: UserInfo) {
    dispatcher.appDidReceive(.remote(userInfo))
  }

  //swiftlint:disable:next line_length
  @available(iOS, introduced: 9.0, deprecated: 10.0, message: "Use UserNotifications Framework's -[UNUserNotificationCenterDelegate didReceiveNotificationResponse:withCompletionHandler:]")
  open func application(_ application: UIApplication,
                        handleActionWithIdentifier identifier: String?,
                        forRemoteNotification userInfo: UserInfo,
                        withResponseInfo responseInfo: ResponseInfo,
                        completionHandler: @escaping VoidHandler) {
    dispatcher.appHandleAction(with: identifier, for: .remote(userInfo),
                               responseInfo: responseInfo, completionHandler: completionHandler)
  }

  //swiftlint:disable:next line_length
  @available(iOS, introduced: 8.0, deprecated: 10.0, message: "Use UserNotifications Framework's -[UNUserNotificationCenterDelegate didReceiveNotificationResponse:withCompletionHandler:]")
  open func application(_ application: UIApplication,
                        handleActionWithIdentifier identifier: String?,
                        forRemoteNotification userInfo: UserInfo,
                        completionHandler: @escaping VoidHandler) {
    dispatcher.appHandleAction(with: identifier, for: .remote(userInfo),
                               responseInfo: nil, completionHandler: completionHandler)
  }

  //swiftlint:disable:next line_length
  @available(iOS, introduced: 4.0, deprecated: 10.0, message: "Use UserNotifications Framework's -[UNUserNotificationCenterDelegate willPresentNotification:withCompletionHandler:] or -[UNUserNotificationCenterDelegate didReceiveNotificationResponse:withCompletionHandler:]")
  open func application(_ application: UIApplication,
                        didReceive notification: UILocalNotification) {
    dispatcher.appDidReceive(.local(notification))
  }

  //swiftlint:disable:next line_length
  @available(iOS, introduced: 8.0, deprecated: 10.0, message: "Use UserNotifications Framework's -[UNUserNotificationCenterDelegate didReceiveNotificationResponse:withCompletionHandler:]")
  open func application(_ application: UIApplication,
                        handleActionWithIdentifier identifier: String?,
                        for notification: UILocalNotification,
                        completionHandler: @escaping VoidHandler) {
    dispatcher.appHandleAction(with: identifier, for: .local(notification),
                               responseInfo: nil, completionHandler: completionHandler)
  }

  //swiftlint:disable:next line_length
  @available(iOS, introduced: 9.0, deprecated: 10.0, message: "Use UserNotifications Framework's -[UNUserNotificationCenterDelegate didReceiveNotificationResponse:withCompletionHandler:]")
  open func application(_ application: UIApplication,
                        handleActionWithIdentifier identifier: String?,
                        for notification: UILocalNotification,
                        withResponseInfo responseInfo: UserInfo,
                        completionHandler: @escaping VoidHandler) {
    dispatcher.appHandleAction(with: identifier, for: .local(notification),
                               responseInfo: responseInfo, completionHandler: completionHandler)
  }

  // MARK: - Background

  open func application(_ application: UIApplication,
                        didReceiveRemoteNotification userInfo: UserInfo,
                        fetchCompletionHandler completionHandler: @escaping BackgroundFetchResultHandler) {
    dispatcher.appReadyFetchDataForRemoteNotification(with: userInfo, fetchHandler: completionHandler)
  }

  open func application(_ application: UIApplication,
                        performFetchWithCompletionHandler completionHandler: @escaping BackgroundFetchResultHandler) {
    dispatcher.appPerformFetch(with: completionHandler)
  }

  open func application(_ application: UIApplication,
                        handleEventsForBackgroundURLSession identifier: String,
                        completionHandler: @escaping VoidHandler) {
    dispatcher.appHandleEventsForBackgroundURLSession(with: identifier, completionHandler: completionHandler)
  }

  // MARK: - Shorcuts

  open func application(_ application: UIApplication,
                        performActionFor shortcutItem: UIApplicationShortcutItem,
                        completionHandler: @escaping BoolHandler) {
    dispatcher.appPerformAction(for: shortcutItem, completionHandler: completionHandler)
  }

  // MARK: - WatchKit

  open func application(_ application: UIApplication,
                        handleWatchKitExtensionRequest userInfo: UserInfo?,
                        reply: @escaping UserInfoHandler) {
    dispatcher.appHandleWatchKitExtensionRequest(with: userInfo, reply: reply)
  }

  // MARK: - HealthKit

  @available(iOS 9.0, *)
  open func applicationShouldRequestHealthAuthorization(_ application: UIApplication) {
    dispatcher.appShouldRequestHealthAuthorization()
  }

  // MARK: - Protected Data

  open func applicationProtectedDataWillBecomeUnavailable(_ application: UIApplication) {
    dispatcher.appProtectedDataWillBecomeUnavailable()
  }

  open func applicationProtectedDataDidBecomeAvailable(_ application: UIApplication) {
    dispatcher.appProtectedDataDidBecomeAvailable()
  }

  // MARK: - Extensions

  //swiftlint:disable line_length
  open func application(_ application: UIApplication,
                        shouldAllowExtensionPointIdentifier extensionPointIdentifier: UIApplication.ExtensionPointIdentifier) -> Bool {
    return dispatcher.appShouldAllow(extensionPointIdentifier: extensionPointIdentifier)
  }
  //swiftlint:enable line_length

  // MARK: - Restoration

  open func application(_ application: UIApplication,
                        viewControllerWithRestorationIdentifierPath identifierComponents: [Any],
                        coder: NSCoder) -> UIViewController? {
    return dispatcher.appViewController(with: identifierComponents, coder: coder)
  }

  open func application(_ application: UIApplication, shouldSaveApplicationState coder: NSCoder) -> Bool {
    return dispatcher.appShouldSaveApplicationState(coder: coder)
  }

  open func application(_ application: UIApplication, shouldRestoreApplicationState coder: NSCoder) -> Bool {
    return dispatcher.appShouldRestoreApplicationState(coder: coder)
  }

  open func application(_ application: UIApplication, willEncodeRestorableStateWith coder: NSCoder) {
    dispatcher.appWillEncodeRestorableState(with: coder)
  }

  open func application(_ application: UIApplication, didDecodeRestorableStateWith coder: NSCoder) {
    dispatcher.appDidDecodeRestorableState(with: coder)
  }

  // MARK: - User Activity

  open func application(_ application: UIApplication,
                        willContinueUserActivityWithType userActivityType: String) -> Bool {
    return dispatcher.appWillContinueUserActivity(with: userActivityType)
  }

  open func application(_ application: UIApplication,
                        continue userActivity: NSUserActivity,
                        restorationHandler: @escaping RestorationHandler) -> Bool {
    return dispatcher.appContinue(userActivity: userActivity, restorationHandler: restorationHandler)
  }

  open func application(_ application: UIApplication,
                        didFailToContinueUserActivityWithType userActivityType: String,
                        error: Error) {
    dispatcher.appDidFailToContinueUserActivity(with: userActivityType, error: error)
  }

  open func application(_ application: UIApplication,
                        didUpdate userActivity: NSUserActivity) {
    dispatcher.appDidUpdate(userActivity: userActivity)
  }
}
