//
//  UIService.swift
//  Astrarium
//
//  Created by Dmitry Duleba on 4/9/19.
//

import Astrarium

extension ServiceIds {

  // swiftlint:disable:next identifier_name
  static let ui = ServiceIdentifier<UIService>()

}

final class UIService: AppService {

  let window = UIWindow(frame: UIScreen.main.bounds)

  func setup(with launchOptions: LaunchOptions) {
//    UI.baseWidths = [.pad: 768, .phone: 375]
    showSplash()
  }

  func appInterfaceOrientationMask(for window: UIWindow?) -> UIInterfaceOrientationMask {
    return .allButUpsideDown
  }

  func priority(for event: AppEvent) -> Priority {
    if event == .launch { return .high }
    return .default
  }

}

// MARK: - Private

private extension UIService {

  func showSplash() {
    didShowSplash()
  }

  func didShowSplash() {
    showMainScreen()
  }

  func showMainScreen() {
    let mainVC = ViewController()
    window.rootViewController = mainVC
    window.makeKeyAndVisible()
  }

}
