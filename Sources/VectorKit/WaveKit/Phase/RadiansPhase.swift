//
//  RadiansPhase.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 14/2/2026.
//

import Foundation

public struct RadiansPhase<T: WaveFloat>: Sendable, Hashable, Codable {
  
  /// Always wrapped to [0, 2π)
  public var radians: T
  
  public init(_ radians: T) { self.radians = Self.wrap(radians) }
}

extension RadiansPhase {
  
  public mutating func advance(by dRadians: T) { radians = Self.wrap(radians + dRadians) }
  
  @inline(__always) public static func wrap(_ x: T) -> T {
    let twoPi = T.twoPi
    let y = x.truncatingRemainder(dividingBy: twoPi)
    return y < 0 ? y + twoPi : y
  }
  
  @inline(__always) public var turns: T { radians / T.twoPi }
}
