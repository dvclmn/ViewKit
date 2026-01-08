//
//  UnitPosition.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 8/1/2026.
//

import Foundation

/// The metric counterpart to `GridPosition`
public struct UnitPosition: Hashable, Codable, Sendable {
  public var x: UnitLength
  public var y: UnitLength

  public init(x: UnitLength, y: UnitLength) {
    self.x = x
    self.y = y
  }
}

extension UnitPosition {
  
  public init(_ x: UnitLength, _ y: UnitLength) {
    self.x = x
    self.y = y
  }
  
  public init?(
    fromCGPoint point: CGPoint,
    unitSize: CGSize,
    rounding: GridRounding = .down
  ) {
    guard let gridX = point.x.toGridCount(using: unitSize.width, rounding: rounding),
      let gridY = point.y.toGridCount(using: unitSize.height, rounding: rounding)
    else { return nil }
    
    let x = UnitLength(
      magnitude: gridX,
      unitLength: unitSize.width
    )
    let y = UnitLength(
      magnitude: gridY,
      unitLength: unitSize.height
    )
    self.init(x, y)
  }
}
