//
//  GridRect.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 2/3/2026.
//

public struct GridRect: Sendable, Codable, Equatable, Hashable {
  public var origin: GridPosition  // top-left
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

  public var min: GridPosition { origin }
  public var max: GridPosition {
    .init(
      column: origin.column + size.width - 1,
      row: origin.row + size.height - 1
    )
  }

  public func contains(_ position: GridPosition) -> Bool {
    (min...max).contains(position)
  }
}
