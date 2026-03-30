//
//  RadialDirection.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 10/1/2026.
//

import SwiftUI
import GeometryPrimitives

/// In some cases (like for `UnitPoint`) directionality can be inferred
public enum RadialDirection: Sendable {
  case outward
  case inward
}

extension RadialDirection {

}

extension UnitPoint {

  /// If left nil, the radial direction will be inferred from `self`,
  /// using a product of the origin (0.5) and the provided coordinate's value
  func directionMultiplier(
    for axis: GridAxis,
    mapping: AxisMapping = .default,
    radial radialDirection: RadialDirection? = nil,
  ) -> CGFloat {
    let axisValue = value(along: axis, mapping: mapping)

    fatalError("Need to be finished")
    //    if let radialDirection {
    //      radialDirection.is
    //    }
    //
    // No explicit radial direction: infer based on position relative to center (0.5)
    if axisValue < 0.5 { return +1 }
    if axisValue > 0.5 { return -1 }
    return 0

  }
}
