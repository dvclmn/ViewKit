//
//  SizeSnapStrategy.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 6/1/2026.
//

import Foundation

public enum SnapStrategy {
  case floor
  case ceil
  case round
}

extension SnapStrategy {
  func snapped<T: BinaryFloatingPoint>(_ value: T) -> T {
    switch self {
      case .floor:
        return Foundation.floor(value)
      case .ceil:
        return Foundation.ceil(value)
      case .round:
        return Foundation.round(value)
    }
  }
  
  func snapped(_ value: CGFloat) -> Int {
    switch self {
      case .floor:
        return Int(Foundation.floor(value))
      case .ceil:
        return Int(Foundation.ceil(value))
      case .round:
        return Int(Foundation.round(value))
    }
  }
}
