//
//  ApplicationDelegate.swift
//  Demo
//
//  Created by Dmitry Duleba on 5/23/18.
//  Copyright © 2018 NetcoSports. All rights reserved.
//

import UIKit

@UIApplicationMain
class ApplicationDelegate: AppDelegate {

  var window: UIWindow?

  func applicationDidFinishLaunching(_ application: UIApplication) {
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = ViewController()
    window?.makeKeyAndVisible()
  }
}
