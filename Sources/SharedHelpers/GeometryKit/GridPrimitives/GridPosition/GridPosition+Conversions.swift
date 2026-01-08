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
    
    let colRounded = colThing.rounded(using: rounding)
    let rowRounded = rowThing.rounded(using: rounding)
    
//    let x: CGFloat = colRounded / CGFloat(dimensions.width)
//    let y: CGFloat = rowRounded / CGFloat(dimensions.height)
    
    return GridPosition(<#T##row: Int##Int#>, <#T##column: Int##Int#>)
    
    
//    GridPosition(
//      column: (x * CGFloat(dimensions.width)).rounded(using: rounding).intValue,
//      row: (y * CGFloat(dimensions.height)).rounded(using: rounding).intValue
//    )
  }
}
