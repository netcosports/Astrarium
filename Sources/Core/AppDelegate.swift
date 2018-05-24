//
//  AppDelegate.swift
//  Astrarium
//
//  Created by Dmitry Duleba on 5/23/18.
//

import UIKit

open class AppDelegate: UIResponder, UIApplicationDelegate {

  private(set) lazy var dispatcher: Dispatcher = {
    let dispatcher = Dispatcher(services: services)
    type(of: dispatcher).register(shared: dispatcher)
    return dispatcher
  }()

  open var services: [ServiceIds?] { return [] }

  open func application(_ application: UIApplication,
                          willFinishLaunchingWithOptions launchOptions: LaunchOptions? = nil) -> Bool {
    dispatcher.application(application, willFinishLaunchingWithOptions: launchOptions)
    return true
  }

  open func application(_ application: UIApplication,
                          didFinishLaunchingWithOptions launchOptions: LaunchOptions?) -> Bool {
    dispatcher.application(application, didFinishLaunchingWithOptions: launchOptions)
    return true
  }

  open func applicationDidBecomeActive(_ application: UIApplication) {
    dispatcher.applicationDidBecomeActive(application)
  }

  open func applicationWillResignActive(_ application: UIApplication) {
    dispatcher.applicationWillResignActive(application)
  }

  open func applicationWillEnterForeground(_ application: UIApplication) {
    dispatcher.applicationWillEnterForeground(application)
  }

  open func applicationDidEnterBackground(_ application: UIApplication) {
    dispatcher.applicationDidEnterBackground(application)
  }

  open func application(_ app: UIApplication, open url: URL, options: OpenURLOptions = [:]) -> Bool {
    if dispatcher.application(app, open: url, options: options) {
      return true
    }
    return false
  }

  open func applicationWillTerminate(_ application: UIApplication) {
    dispatcher.applicationWillTerminate(application)
  }
}
