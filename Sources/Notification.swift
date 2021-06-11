//
//  Notification.swift
//  Astrarium
//
//  Created by Dmitry Duleba on 6/13/18.
//

import Foundation
import UIKit

public enum Notification {

  case local(UILocalNotification)
  case remote(UserInfo)

}
