//
//  GridRect.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 2/3/2026.
//

public struct GridRect: Sendable, Codable, Equatable, Hashable {
  public var origin: GridPosition
  public var size: GridDimensions

  public init(origin: GridPosition, size: GridDimensions) {
    self.origin = origin
    self.size = size
  }
}

extension GridRect {
  public init(x: Int, y: Int, width: Int, height: Int) {
    self.origin = GridPosition(x: x, y: y)
    self.size = GridDimensions(width, height)
  }
}
