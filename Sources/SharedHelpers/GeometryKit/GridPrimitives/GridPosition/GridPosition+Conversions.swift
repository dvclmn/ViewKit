//
//  GridPosition+Conversions.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 8/1/2026.
//

import SwiftUI

extension UnitPoint {
  public func toGridPosition(
    in dimensions: GridDimensions,
    rounding: GridRounding
  ) -> GridPosition {

    let colThing: CGFloat = x * CGFloat(dimensions.width)
    let rowThing: CGFloat = y * CGFloat(dimensions.height)

    let colRounded = colThing.roundedInt(using: rounding)
    let rowRounded = rowThing.roundedInt(using: rounding)

    return GridPosition(colRounded, rowRounded)
  }
}
