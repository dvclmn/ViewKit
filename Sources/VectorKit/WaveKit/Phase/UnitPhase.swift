//
//  UnitPhase.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 14/2/2026.
//

import Foundation

public struct UnitPhase<T: WaveFloat>: Sendable, Hashable, Codable {
  
  /// Always wrapped to [0, 1)
  public var turns: T
  
  public init(_ turns: T) { self.turns = Self.wrap(turns) }
  
  public mutating func advance(by dTurns: T) { turns = Self.wrap(turns + dTurns) }
  
  @inline(__always) public static func wrap(_ u: T) -> T {
    let y = u - floor(u)
    return y < 0 ? y + 1 : y
  }
  
  @inline(__always) public var radians: T { turns * T.twoPi }
}
