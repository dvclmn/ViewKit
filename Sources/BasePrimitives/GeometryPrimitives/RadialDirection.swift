//
//  RadialDirection.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 10/1/2026.
//

import InteractionKit
import SwiftUI

/// In some cases (like for `UnitPoint`) directionality can be inferred
public enum RadialDirection: Sendable {
  case outward
  case inward
}

extension RadialDirection {
  /// Returns +1 for outward, -1 for inward
  var multiplier: CGFloat {
    switch self {
      case .outward: +1
      case .inward: -1
    }
  }
}

extension UnitPoint {

  /// If left nil, the radial direction will be inferred from `self`,
  /// using a product of the origin (0.5) and the provided coordinate's value
  func directionMultiplier(
    for axis: GeometryAxis,
    mapping: AxisMapping = .default,
    radial radialDirection: RadialDirection? = nil,
  ) -> CGFloat {
    let axisValue = value(along: axis, mapping: mapping)

    /// If an explicit radial direction is provided, use it directly
    if let radialDirection {
      return radialDirection.multiplier
    }

    /// No explicit radial direction: infer based on position relative to center (0.5)
    if axisValue < 0.5 { return +1 }
    if axisValue > 0.5 { return -1 }
    return 0
  }
}
