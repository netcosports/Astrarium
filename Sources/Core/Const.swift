//
//  Const.swift
//  Astrarium
//
//  Created by Dmitry Duleba on 5/23/18.
//

import UIKit

public typealias LaunchOptions = [UIApplication.LaunchOptionsKey: Any]
public typealias OpenURLOptions = [UIApplication.OpenURLOptionsKey: Any]
public typealias UserInfo = [AnyHashable: Any]
public typealias ResponseInfo = [AnyHashable: Any]
public typealias VoidHandler = () -> Swift.Void
public typealias BoolHandler = (Swift.Bool) -> Swift.Void
public typealias BackgroundFetchResultHandler = (UIBackgroundFetchResult) -> Swift.Void
public typealias UserInfoHandler = (UserInfo?) -> Swift.Void
public typealias RestorationHandler = ([Any]?) -> Swift.Void
