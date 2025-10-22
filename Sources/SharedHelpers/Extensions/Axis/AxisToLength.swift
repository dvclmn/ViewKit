//
//  AxisToLength.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 22/10/2025.
//

import SwiftUI

extension Axis {
  /// Returns the length for this axis from a `CGSize`,
  /// interpreting width/height according to the given convention.
  public func length(
    fromSize size: CGSize,
    convention: DimensionToAxisConvention = .widthIsHorizontal
  ) -> CGFloat {
    switch self {
      case .horizontal:
        return convention.horizontalLength(size: size)
      case .vertical:
        return convention.verticalLength(size: size)
    }
  }
  
  /// Returns the total inset length for this axis from `CGRect`,
  /// interpreting width/height according to the given convention.
  public func length(
    fromRect rect: CGRect,
    convention: DimensionToAxisConvention = .widthIsHorizontal
  ) -> CGFloat {
    switch self {
      case .horizontal:
        return convention.horizontalLength(rect: rect)
      case .vertical:
        return convention.verticalLength(rect: rect)
    }
  }
  
  /// Returns the sum of the two *opposing* inset lengths, for this axis,
  /// interpreting leading/trailing/top/bottom according to the given convention.
  public func length(
    fromInsets edgeInsets: EdgeInsets,
    convention: DimensionToAxisConvention = .widthIsHorizontal
  ) -> CGFloat {
    switch self {
      case .horizontal:
        return convention.horizontalLength(edgeInsets: edgeInsets)
      case .vertical:
        return convention.verticalLength(edgeInsets: edgeInsets)
    }
  }
  
  /// Returns the float value for this axis from a `CGPoint`,
  /// interpreting x/y according to the given convention.
  public func point(
    fromPoint point: CGPoint,
    convention: DimensionToAxisConvention = .widthIsHorizontal
  ) -> CGFloat {
    switch self {
      case .horizontal:
        return convention.horizontalPoint(point: point)
      case .vertical:
        return convention.verticalPoint(point: point)
    }
  }

}
