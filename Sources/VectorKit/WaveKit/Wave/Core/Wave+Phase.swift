//
//  Wave+Phase.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 4/2/2026.
//

import Foundation

extension WaveShaped {
  @inline(__always)
  static func wrapToTwoPi(_ x: Value) -> Value {
    let twoPi = Value.twoPi
    let y = x.truncatingRemainder(dividingBy: twoPi)
    return y < 0 ? y + twoPi : y
  }

  @inline(__always)
  static func wrapUnit(_ u: Value) -> Value {
    let y = u - floor(u)
    return y < 0 ? y + 1 : y
  }

  @inline(__always)
  static func unitToRadians(_ u: Value) -> Value { u * Value.twoPi }

  @inline(__always)
  static func radiansToUnit(_ r: Value) -> Value { r / Value.twoPi }
}
