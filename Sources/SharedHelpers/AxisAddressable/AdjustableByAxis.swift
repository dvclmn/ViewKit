//
//  FloatAdjustable.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 15/12/2025.
//

import Foundation

/// Provides a convenient adjustment mechanism
/// for types with more than one float/integer value
///
/// Doesn't need to know about dimensions (width/height),
/// or axes (x/y) or indices (row/col) at all.
///
/// Operates purely in terms of:
/// - Axis
/// - Scalar values
/// - Reconstruction
///
/// And lets the convention do the mapping.
public protocol AdjustableByAxis: AxisKeyPathCompatible {}

// MARK: - Adjustable
extension CGSize: AdjustableByAxis {}
extension CGPoint: AdjustableByAxis {}

extension AdjustableByAxis {

  public func adjust(
    _ axis: Axis2D,
    newValue: Component,
    mapping: AxisMapping = .default
  ) -> Self {
    setting(newValue, along: axis, mapping: mapping)
  }

  public func adjust(
    _ axis: Axis2D,
    transform: (Component) -> Component,
    mapping: AxisMapping = .default
  ) -> Self {
    let current = value(along: axis, mapping: mapping)
    let transformed = transform(current)
    return setting(transformed, along: axis, mapping: mapping)
  }
}

extension AdjustableByAxis where Component: BinaryFloatingPoint {

  /// Apply the same unary transform to both axes independently
  public func adjustBoth(
    transform: (Component) -> Component
  ) -> Self {
    let h = value(along: .horizontal)
    let v = value(along: .vertical)

    let newH = transform(h)
    let newV = transform(v)

    let result =
      self
      .setting(newH, along: .horizontal)
      .setting(newV, along: .vertical)
    return result
  }

  /// Multiply both axes by the same factor
  /// Mapping is not required here, transform is symmetrical
  public func multiplyBoth(by factor: Component) -> Self {
    return self.adjustBoth { $0 * factor }
  }

  public func multiplyBoth(
    by factorProvider: Self,
    using axis: Axis2D,
    mapping: AxisMapping = .default
  ) -> Self {
    let factor = factorProvider.value(along: axis, mapping: mapping)
    return self.adjustBoth(mapping: mapping) { a, b in
      (a * factor, b * factor)
    }
  }

  /// Divide both axes by the same divisor, clamping at 0
  public func divideBoth(by divisor: Component) -> Self {
    return self.adjustBoth { value in
      let divided = value / divisor
      return Swift.max(0, divided)
    }
  }

  public func divideBoth(
    by divisorProvider: Self,
    using axis: Axis2D,
    mapping: AxisMapping = .default
  ) -> Self {
    let divisor = divisorProvider.value(along: axis, mapping: mapping)
    return self.adjustBoth(mapping: mapping) { a, b in
      let aSafe = Swift.max(0, a / divisor)
      let bSafe = Swift.max(0, b / divisor)
      return (aSafe, bSafe)
    }
  }

  /// Apply a binary transform that can coordinate both axes together
  /// The transform receives (h, v) and returns (newH, newV)
  private func adjustBoth(
    mapping: AxisMapping = .default,
    transform: (Component, Component) -> (Component, Component)
  ) -> Self {
    let h = value(along: .horizontal, mapping: mapping)
    let v = value(along: .vertical, mapping: mapping)
    let (newH, newV) = transform(h, v)

    let result =
      self
      .setting(newH, along: .horizontal, mapping: mapping)
      .setting(newV, along: .vertical, mapping: mapping)
    return result
  }

}
