//
//  AxisToLength.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 22/10/2025.
//

import SwiftUI

extension AxisRepresentable {
  /// Returns the length for this axis from a `CGSize`,
  /// interpreting width/height according to the given convention.
  public func length(
    fromSize size: CGSize,
    convention: AxisConvention = .widthIsHorizontal
  ) -> CGFloat {
    switch self {
      case .horizontal:
        convention.horizontalLength(size: size)
      case .vertical:
        convention.verticalLength(size: size)
      default: fatalError("Unknown axis \(self)")
    }
  }

  /// Returns the length for this axis from `CGRect`,
  /// interpreting width/height according to the given convention.
  public func length(
    fromRect rect: CGRect,
    convention: AxisConvention = .widthIsHorizontal
  ) -> CGFloat {
    switch self {
      case .horizontal:
        convention.horizontalLength(rect: rect)
      case .vertical:
        convention.verticalLength(rect: rect)
      default: fatalError("Unknown axis \(self)")
    }
  }

  /// Returns the sum of the two *opposing* inset lengths, for this axis,
  /// interpreting leading/trailing/top/bottom according to the given convention.
  public func length(
    fromInsets edgeInsets: EdgeInsets,
    convention: AxisConvention = .widthIsHorizontal
  ) -> CGFloat {
    switch self {
      case .horizontal:
        convention.horizontalLength(edgeInsets: edgeInsets)
      case .vertical:
        convention.verticalLength(edgeInsets: edgeInsets)
      default: fatalError("Unknown axis \(self)")
    }
  }

  /// Returns the float value for this axis from a `CGPoint`,
  /// interpreting x/y according to the given convention.
  public func point(
    fromPoint point: CGPoint,
    convention: AxisConvention = .widthIsHorizontal
  ) -> CGFloat {
    switch self {
      case .horizontal:
        convention.horizontalPoint(point: point)
      case .vertical:
        convention.verticalPoint(point: point)
      default: fatalError("Unknown axis \(self)")
    }
  }

}
