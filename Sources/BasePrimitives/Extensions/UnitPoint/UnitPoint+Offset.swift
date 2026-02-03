//
//  UnitPoint+Offset.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 30/7/2025.
//

import SwiftUI

extension UnitPoint {

  /// Returns an offset based on this UnitPoint's position.
  /// Positive `dx`/`dy` will push away from edges, negative will pull inward.
  public func offset(dx: CGFloat, dy: CGFloat) -> CGSize {
    CGSize(
      width: Self.directionMultiplier(for: x) * dx,
      height: Self.directionMultiplier(for: y) * dy
    )
  }

  public func offset(by amount: CGFloat) -> CGSize {
    offset(dx: amount, dy: amount)
  }

//  public func offset(by other: Self) -> Self {
//    offset(dx: other.x, dy: other.y)
//  }

  public func offset(
    by size: CGSize,
    mapping: AxisMapping = .default,
    //    convention: AxisConvention = .widthIsHorizontal
  ) -> CGSize {
    offset(
      dx: size.value(along: .horizontal, mapping: mapping),
      dy: size.value(along: .vertical, mapping: mapping),
      //      dx: convention.horizontalLength(size: size),
      //      dy: convention.verticalLength(size: size)
    )
  }

  private static func directionMultiplier(for coordinate: CGFloat) -> CGFloat {
    coordinate < 0.5 ? +1 : coordinate > 0.5 ? -1 : 0
  }

  //  private func directionMultiplier(
  //    for axis: Axis2D,
  //    mapping: AxisMapping = .default,
  //    radial radialDirection: RadialDirection? = nil
  //  ) -> CGFloat {
  //    // Choose the relevant coordinate (x for horizontal, y for vertical) in UnitPoint space [0,1]
  //    let coordinate: CGFloat
  //    switch axis {
  //      case .horizontal:
  //        coordinate = self.x
  //      case .vertical:
  //        coordinate = self.y
  //    }
  //
  //    // If a radial direction is specified, honor it explicitly.
  //    if let radialDirection {
  //      switch radialDirection {
  //        case .outward:
  //          // Outward means push away from the center, so sign depends on which side of the center we are on.
  //          if coordinate < 0.5 { return +1 }
  //          if coordinate > 0.5 { return -1 }
  //          return 0
  //        case .inward:
  //          // Inward means pull toward the center, invert the outward logic.
  //          if coordinate < 0.5 { return -1 }
  //          if coordinate > 0.5 { return +1 }
  //          return 0
  //      }
  //    }
  //
  //    // No explicit radial direction: infer based on position relative to center (0.5)
  //    if coordinate < 0.5 { return +1 }
  //    if coordinate > 0.5 { return -1 }
  //    return 0
  //  }

}
