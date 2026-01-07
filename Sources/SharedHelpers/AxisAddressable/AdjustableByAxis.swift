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
public protocol AdjustableByAxis: AxisAddressable {}
public protocol AdjustableByGridAxis: GridAxisAddressable {}

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

}

extension AdjustableByAxis where Value: BinaryFloatingPoint {

  /// Multiply both axes by the same factor
  public func multiplyBoth(by factor: Value) -> Self {
    return self.adjustBoth { ($0 * factor, $1 * factor) }
  }

//  public func multiplyBoth(
//    by factorProvider: Self,
//    //        _ axis: Axis2D,
//    //    transform: (Value) -> Value,
//    convention: AxisConvention = .default
//  ) -> Self {
//    //    let current = value(for: axis, convention: convention)
//    //    let transformed = transform(current)
//    //    return setting(transformed, for: axis, convention: convention)
//    let factorA = factorProvider.value(for: .horizontal, convention: convention)
//    let factorB = factorProvider.value(for: .vertical, convention: convention)
//    return self.adjustBoth(convention: convention) { a, b in
//      (a * factorA, b * factorB)
//    }
//  }

  /// Multiply both axes by the same factor
  public func divideBoth(by divisor: Value) -> Self {
    return self.adjustBoth { a, b in
      let aSafe = max(0, a / divisor)
      let bSafe = max(0, b / divisor)
      return (aSafe, bSafe)
    }
  }

//  public func divideBoth(
//    by divisorProvider: Self,
//    //        _ axis: Axis2D,
//    //    transform: (Value) -> Value,
//    convention: AxisConvention = .default
//  ) -> Self {
//    //    let current = value(for: axis, convention: convention)
//    //    let transformed = transform(current)
//    //    return setting(transformed, for: axis, convention: convention)
//    let divisorA = divisorProvider.value(for: .horizontal, convention: convention)
//    let divisorB = divisorProvider.value(for: .vertical, convention: convention)
//    //    let needsDivision = self.value(for: axis, convention: convention)
//    return self.adjustBoth(convention: convention) { a, b in
//      let aSafe = Swift.max(0, a / divisorA)
//      let bSafe = Swift.max(0, b / divisorB)
//      return (aSafe, bSafe)
//    }
//  }

  /// Have made this a private-only helper for the above, because I was concerned that the whole
  /// convention thing is not even enforced here, which seems like a recipe for disaster.
  private func adjustBoth(
    convention: AxisConvention = .default,
    transform: (Value, Value) -> (Value, Value),
  ) -> Self {
    let h = value(for: .horizontal, convention: convention)
    let v = value(for: .vertical, convention: convention)
    let (newH, newV) = transform(h, v)

    let result = self.setting(newH, for: .horizontal, convention: convention)
      .setting(newV, for: .vertical, convention: convention)
    return result
  }
}
