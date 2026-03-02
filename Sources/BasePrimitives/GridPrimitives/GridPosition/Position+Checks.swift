//
//  Position+Checks.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 2/3/2026.
//

import Foundation

extension GridPosition {

  public var isGreaterThanZero: Bool {
    return column > 0 && row > 0
  }

  public var isGreaterThanOrEqualToZero: Bool {
    return column >= 0 && row >= 0
  }

  public func isValidWithin(dimensions: GridDimensions) -> Bool {
    return dimensions.contains(position: self)
  }
}
