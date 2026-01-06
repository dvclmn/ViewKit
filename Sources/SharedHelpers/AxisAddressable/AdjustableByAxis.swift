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
/// Doesn't need to know about width/height at all.
/// Operates purely in terms of:
/// - Axis
/// - Scalar values
/// - Reconstruction
///
/// And lets the convention do the mapping.
//public protocol AdjustableByAxis {
//  associatedtype Value: FloatPair
//}

public protocol AdjustableByAxis: AxisAddressable {}

extension AdjustableByAxis {

  public func adjust(
    _ axis: Axis2D,
    newValue: Value,
    convention: AxisConvention = .default
  ) -> Self {
    setting(newValue, for: axis, convention: convention)
  }

  public func adjust(
    _ axis: Axis2D,
    transform: (Value) -> Value,
    convention: AxisConvention = .default
  ) -> Self {
    let current = value(for: axis, convention: convention)
    let transformed = transform(current)
    return setting(transformed, for: axis, convention: convention)
  }

  public func adjustBoth(
    transform: (Value, Value) -> (Value, Value),
    convention: AxisConvention = .default
  ) -> Self {
    let h = value(for: .horizontal, convention: convention)
    let v = value(for: .vertical, convention: convention)
    let (newH, newV) = transform(h, v)

    return
      self
      .setting(newH, for: .horizontal, convention: convention)
      .setting(newV, for: .vertical, convention: convention)
  }

  /// Multiply both axes by the same factor
  public func multiplyBoth(
    by factor: Value,
    //    _ axis: Axis2D,
    //    transform: (Value) -> Value,
    //    convention: AxisConvention = .default
  ) -> Self {
    //    let current = value(for: axis, convention: convention)
    //    let transformed = transform(current)
    //    return setting(transformed, for: axis, convention: convention)
    return self.adjustBoth { a, b in
      (a * factor, b * factor)
    }
  }

  /// Multiply both axes by the same factor
  public func divideBoth(
    by divisor: Value,
    //    _ axis: Axis2D,
    //    transform: (Value) -> Value,
    //    convention: AxisConvention = .default
  ) -> Self {
    //    let current = value(for: axis, convention: convention)
    //    let transformed = transform(current)
    //    return setting(transformed, for: axis, convention: convention)
    return self.adjustBoth { a, b in
      let aSafe = max(0, a / divisor)
      let bSafe = max(0, b / divisor)
      return (aSafe, bSafe)
    }
  }

  //  public func adjust(
  //    _ axis: Axis2D,
  //    newValue: CGFloat,
  //    convention: AxisConvention = .default
  //  ) -> Self {
  //    switch axis {
  //      case .horizontal:
  //        return Value.init(
  //          first: <#T##BinaryFloatingPoint#>,
  //          second: <#T##BinaryFloatingPoint#>
  //        )
  ////        return CGSize(width: newValue, height: self.height)
  //
  //      case .vertical:
  //        return CGSize(width: self.width, height: newValue)
  //    }
  //  }
  //
  //  /// I think this and the below (that transforms both axes)
  //  /// just allow the caller to hop in and  'do some stuff' to
  //  /// the values, before creating a new size from them.
  //  public func adjustLength(
  //    _ axis: Axis2D,
  //    transform: (CGFloat) -> CGFloat
  //  ) -> CGSize {
  //    let transformed = transform(axis.length(fromSize: self))
  //    return self.adjustLength(axis, newValue: transformed)
  //  }
  //
  //  public func adjustLengths(
  //    transform: (CGFloat, CGFloat) -> (width: CGFloat, height: CGFloat)
  //  ) -> CGSize {
  //    let transformed = transform(self.width, self.height)
  //    return CGSize(width: transformed.width, height: transformed.height)
  //  }
  //
  //  public func adjustLengths(by value: CGFloat) -> CGSize {
  //    return CGSize(self.width * value, self.height * value)
  //    //    let transformed = transform(self.width, self.height)
  //    //    return CGSize(width: transformed.width, height: transformed.height)
  //  }
}
