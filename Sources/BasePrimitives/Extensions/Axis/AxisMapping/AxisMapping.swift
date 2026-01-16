//
//  Model+AxisConvention.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 11/9/2025.
//

import SwiftUI

/// Go to
public enum AxisMapping: Sendable {
  /// # Primary is Horizontal
  /// Normal: Width/Column is Horizontal, Height/Row is Vertical.
  /// Previously: `primaryIsHorizontal` / `widthIsHorizontal`
  case identity

  /// # Primary is Vertical
  /// Flipped: Width/Column is Vertical, Height/Row is Horizontal.
  /// Previously: `primaryIsVertical` / `heightIsHorizontal`
  case transposed

  public static let `default`: Self = .identity

  /// Routes a request to the correct component based on mapping and axis.
  public func select<T>(primary: T, secondary: T, for axis: GridAxis) -> T {
    switch (self, axis) {
      case (.identity, .horizontal), (.transposed, .vertical): return primary
      case (.identity, .vertical), (.transposed, .horizontal): return secondary
    }
  }

  /// Reconstructs a pair in the correct order for the type's storage.
  public func pair<T>(h: T, v: T) -> (primary: T, secondary: T) {
    switch self {
      case .identity: return (h, v)
      case .transposed: return (v, h)
    }
  }

  func resolve<T>(primary: T, secondary: T, for axis: GridAxis) -> T {
    switch (self, axis) {
      case (.identity, .horizontal), (.transposed, .vertical): return primary
      case (.identity, .vertical), (.transposed, .horizontal): return secondary
    }
  }
}

extension AdjustableByAxis {

  public func adjustBoth<Other: AdjustableByAxis>(
    with other: Other,
    transform: (_ lhs: Component, _ rhs: Component) -> Component
  ) -> Self where Other.Component == Component {

    self.adjustBoth(with: other) { _, lhs, rhs in
      transform(lhs, rhs)
    }
  }

  public func adjustBoth<Other: AdjustableByAxis>(
    with other: Other,
    transform: (_ axis: GridAxis, _ lhs: Component, _ rhs: Component) -> Component
  ) -> Self where Other.Component == Component {

    var result = self

    for axis in [GridAxis.horizontal, .vertical] {
      let lhs = self.value(along: axis)
      let rhs = other.value(along: axis)
      let newValue = transform(axis, lhs, rhs)
      result = result.setting(newValue, along: axis)
    }

    return result
  }
}

// MARK: - Deprecations
extension AxisMapping {

  @available(
    *, deprecated, renamed: "identity", message: "Renamed for clarity, please use `.identity` instead"
  )
  public static let primaryIsHorizontal: Self = .identity

  @available(
    *, deprecated, renamed: "transposed", message: "Renamed for clarity, please use `.identity` instead"
  )
  public static let primaryIsVertical: Self = .transposed

}

/// A mapping between `Dimension` (width / height) and `Axis` (horizontal / vertical).
///
/// This aims to answer the question:
/// “Given this dimension-based structure, which scalar corresponds to which axis?”
///
/// In most cases, "width" means "horizontal" and "height" means "vertical".
/// But occasionally this is not the case (rotated coordinate systems, swapped
///  axes, certain drawing transforms), so it's risky to assume.
///
/// `AxisConvention` makes the convention explicit, so there's less risk of confusion
///
/// `.widthIsHorizontal`:
///    width → horizontal length
///    height → vertical length
///
/// `.heightIsHorizontal`:
///    height → horizontal length
///    width → vertical length
///
/// Enables deriving correct values from types like
/// `CGSize`, `CGPoint`, `EdgeInsets` etc
@available(
  *, deprecated, renamed: "AxisMapping", message: "Renamed for clarity, please use `AxisMapping` instead"
)
public enum AxisConvention: Sendable {

  case widthIsHorizontal
  case heightIsHorizontal

}
//
//
//  public static let `default`: Self = .widthIsHorizontal
//}
//
//extension AxisConvention {
//
//  public var widthAxis: Axis2D {
//    switch self {
//      case .widthIsHorizontal: .horizontal
//      case .heightIsHorizontal: .vertical
//    }
//  }
//
//  public var heightAxis: Axis2D {
//    switch self {
//      case .widthIsHorizontal: .vertical
//      case .heightIsHorizontal: .horizontal
//    }
//  }
//}
//
///// This exists alongside `AxisConvention`, to represent index
///// space, where `AxisConvention` represents 'dimension' space
/////
///// In a standard grid, Columns typically represent the horizontal index (X)
///// and Rows represent the vertical index (Y)
//public enum GridAxisConvention: Sendable {
//  case columnIsHorizontal
//  case rowIsHorizontal
//
//  public static let `default`: Self = .columnIsHorizontal
//}
//
//extension GridAxisConvention {
//
//  public var rowAxis: Axis2D {
//    switch self {
//      case .columnIsHorizontal: .vertical
//      case .rowIsHorizontal: .horizontal
//    }
//  }
//
//  public var columnAxis: Axis2D {
//    switch self {
//      case .columnIsHorizontal: .horizontal
//      case .rowIsHorizontal: .vertical
//    }
//  }
//}
