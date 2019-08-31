//
//  Priority.swift
//  Sources
//
//  Created by Dmitry Duleba on 8/31/19.
//

import Foundation

public typealias Priority = Int

public extension Priority {

  static let low: Priority = 0
  static let normal: Priority = 500
  static let high: Priority = 1000

  static var `default`: Priority { return .normal }

}

extension Array where Element == AppService {

  func sortedByPriority(for event: AppEvent) -> Self {
    return sorted { $0.priority(for: event) > $1.priority(for: event) }
  }

}
