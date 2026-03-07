//
//  Direction+Vertical.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 14/1/2026.
//

import Foundation

extension Direction {
  public enum Vertical {
    case up
    case down
  }
}

extension Direction.Vertical {
  public var opposite: Self { isUp ? .down : .up }
  public var isUp: Bool { self == .up }
  public var isDown: Bool { self == .down }
}
