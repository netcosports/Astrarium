//
//  RemoteService.swift
//  Astrarium
//
//  Created by Dmitry Duleba on 4/9/19.
//

import Astrarium

extension ServiceIds {

  static let remote = ServiceIdentifier<RemoteService>()

}

final class RemoteService: AppService {

  func setup(with launchOptions: LaunchOptions) {
//    Gnomon.logging = true
  }

}
