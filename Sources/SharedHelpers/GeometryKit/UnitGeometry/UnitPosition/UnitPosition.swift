//
//  UnitPosition.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 8/1/2026.
//

/// The metric counterpart to `GridPosition`
public struct UnitPosition: Hashable, Codable, Sendable {
  public var x: UnitLength
  public var y: UnitLength
  
  public init(x: UnitLength, y: UnitLength) {
    self.x = x
    self.y = y
  }
}
