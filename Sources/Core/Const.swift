//
//  Const.swift
//  Astrarium
//
//  Created by Dmitry Duleba on 5/23/18.
//

import UIKit

//swiftlint:disable:next identifier_name
public var Service: Dispatcher { return Dispatcher.shared }

public typealias LaunchOptions = [UIApplicationLaunchOptionsKey: Any]
public typealias OpenURLOptions = [UIApplicationOpenURLOptionsKey: Any]
public typealias UserInfo = [AnyHashable : Any]
public typealias VoidHandler = () -> Swift.Void
public typealias BoolHandler = (Swift.Bool) -> Swift.Void
public typealias BackgroundFetchResultHandler = (UIBackgroundFetchResult) -> Swift.Void
public typealias UserInfoHandler = (UserInfo?) -> Swift.Void
public typealias RestorationHandler = ([Any]?) -> Swift.Void
