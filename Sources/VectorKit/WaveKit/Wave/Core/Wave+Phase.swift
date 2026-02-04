//
//  Wave+Phase.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 4/2/2026.
//

import Foundation

extension Wave {

  public var phaseRadians: T { phase }

  public var unitPhase: T { Self.wrapUnit(Self.radiansToUnit(phase)) }

  @inline(__always)
  public static func wrapToTwoPi(_ x: T) -> T {
    let twoPi = (T.twoPi)
    let y = x.truncatingRemainder(dividingBy: twoPi)
    return y < 0 ? y + twoPi : y
  }

  @inline(__always)
  public static func wrapUnit(_ u: T) -> T {
    let y = u - floor(u)
    return y < 0 ? y + 1 : y
  }

  @inline(__always)
  static func unitToRadians(_ u: T) -> T { u * T.twoPi }

  @inline(__always)
  static func radiansToUnit(_ r: T) -> T { r / T.twoPi }
}
