//
//  Adjustable+Conformances.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 6/1/2026.
//

import SwiftUI

extension CGSize: AxisAddressable {
  public var identityComponent: CGFloat {
    get { width }
    set { width = newValue }
  }
  public var transposedComponent: CGFloat {
    get { height }
    set { height = newValue }
  }
}

extension GridPosition: AxisAddressable {
  public var identityComponent: Int {
    get { column }
    set { column = newValue }
  }
  public var transposedComponent: Int {
    get { row }
    set { row = newValue }
  }
}

extension AxisAddressable where Component: BinaryFloatingPoint {
  /// A helper for when you want to create a new instance from H/V values
  public static func make(
    h: Component,
    v: Component,
    mapping: AxisMapping = .identity
  ) -> Self {
    /// Create a dummy instance and then use unified 'setting' logic
    /// This ensures the mapping is applied consistently.
    return Self.zero
      .setting(h, along: .horizontal, mapping: mapping)
      .setting(v, along: .vertical, mapping: mapping)
  }
}

extension EdgeInsets: AxisAddressable {
  public typealias Component = CGFloat
  
  /// Treat the "Primary/Identity" storage as the Lead/Trail pair
  public var identityComponent: CGFloat {
    get { leading + trailing }
    set {
      /// When setting a total, distribute it evenly.
      /// Note: Consider preserving the existing ratio
      let half = newValue / 2
      leading = half
      trailing = half
    }
  }
  
  /// Treat the "Secondary/Transposed" storage as the Top/Bottom pair
  public var transposedComponent: CGFloat {
    get { top + bottom }
    set {
      let half = newValue / 2
      top = half
      bottom = half
    }
  }
}

// MARK: - Addressable
//extension CGSize: AxisAddressable {
//
//  public func value(
//    along axis: Axis2D,
//    convention: AxisConvention
//  ) -> CGFloat {
//    switch axis {
//      case .horizontal: convention.horizontalLength(size: self)
//      case .vertical: convention.verticalLength(size: self)
//    }
//  }
//
//  public func setting(
//    _ newValue: CGFloat,
//    along axis: Axis2D,
//    convention: AxisConvention
//  ) -> Self {
//
//    switch axis {
//      case .horizontal:
//        /// Keep the current vertical, update horizontal
//        return convention.makeCGSize(
//          h: newValue,
//          v: convention.verticalLength(size: self)
//        )
//      case .vertical:
//        /// Keep the current horizontal, update vertical
//        return convention.makeCGSize(
//          h: convention.horizontalLength(size: self),
//          v: newValue
//        )
//    }
//  }
//}
//
//// MARK: - CGPoint
//extension CGPoint: AxisAddressable {
//
//  public func value(
//    along axis: Axis2D,
//    convention: AxisConvention
//  ) -> CGFloat {
//    switch axis {
//      case .horizontal: convention.horizontalValue(for: self)
//      case .vertical: convention.verticalValue(for: self)
//    }
//  }
//
//  public func setting(
//    _ newValue: CGFloat,
//    along axis: Axis2D,
//    convention: AxisConvention
//  ) -> Self {
//    switch axis {
//      case .horizontal:
//        /// Keep the current vertical, update horizontal
//        return convention.makeCGPoint(
//          h: newValue,
//          v: convention.verticalValue(for: self)
//        )
//      case .vertical:
//        /// Keep the current horizontal, update vertical
//        return convention.makeCGPoint(
//          h: convention.horizontalValue(for: self),
//          v: newValue
//        )
//    }
//  }
//}
//
//
//// MARK: - UnitPoint
//extension UnitPoint: AxisAddressable {
//  
//  public func value(
//    along axis: Axis2D,
//    convention: AxisConvention
//  ) -> CGFloat {
//    switch axis {
//      case .horizontal: convention.horizontalValue(for: self)
//      case .vertical: convention.verticalValue(for: self)
//    }
//  }
//  
//  public func setting(
//    _ newValue: CGFloat,
//    along axis: Axis2D,
//    convention: AxisConvention
//  ) -> Self {
//    switch axis {
//      case .horizontal:
//        /// Keep the current vertical, update horizontal
//        return convention.makeUnitPoint(
//          h: newValue,
//          v: convention.verticalValue(for: self)
//        )
//      case .vertical:
//        /// Keep the current horizontal, update vertical
//        return convention.makeUnitPoint(
//          h: convention.horizontalValue(for: self),
//          v: newValue
//        )
//    }
//  }
//}
//
//
//// MARK: - GridPosition
//extension GridPosition: GridAxisAddressable {
//
//  public func value(along axis: Axis2D, convention: GridAxisConvention) -> Int {
//    switch axis {
//      case .horizontal: return convention.horizontalValue(for: self)
//      case .vertical: return convention.verticalValue(for: self)
//    }
//  }
//
//  public func setting(
//    _ newValue: Int,
//    along axis: Axis2D,
//    convention: GridAxisConvention
//  ) -> Self {
//    switch axis {
//      case .horizontal:
//        return convention.makeGridPosition(
//          h: newValue,
//          v: convention.verticalValue(for: self)
//        )
//      case .vertical:
//        return convention.makeGridPosition(
//          h: convention.horizontalValue(for: self),
//          v: newValue
//        )
//    }
//  }
//
//}
//
//extension GridSize: GridAxisAddressable {
//
//  public func value(along axis: Axis2D, convention: GridAxisConvention) -> GridLength {
//    switch axis {
//      case .horizontal: return convention.horizontalLength(gridSize: self)
//      case .vertical: return convention.verticalLength(gridSize: self)
//    }
//  }
//
//  public func setting(
//    _ newValue: GridLength,
//    along axis: Axis2D,
//    convention: GridAxisConvention
//  ) -> Self {
//    switch axis {
//      case .horizontal:
//        return convention.makeGridSize(
//          h: newValue,
//          v: convention.verticalLength(gridSize: self)
//        )
//      case .vertical:
//        return convention.makeGridSize(
//          h: convention.horizontalLength(gridSize: self),
//          v: newValue
//        )
//    }
//  }
//}
