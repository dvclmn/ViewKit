//
//  FloatAdjustable.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 15/12/2025.
//

import Foundation

/// Provides a convenient adjustment mechanism
/// for types with more than one float value
///
/// Uses protocol `FloatPair` as one way to address values,
/// and likely more to come, such as `FloatTriplet` etc
public protocol AdjustableByAxis {
  associatedtype Value: FloatPair
}

extension AdjustableByAxis {

  public func adjust(
    _ axis: Axis2D,
    newValue: CGFloat,
    convention: AxisConvention = .default
  ) -> Self {
    switch axis {
      case .horizontal:
        return Value.init(
          first: <#T##BinaryFloatingPoint#>,
          second: <#T##BinaryFloatingPoint#>
        )
//        return CGSize(width: newValue, height: self.height)

      case .vertical:
        return CGSize(width: self.width, height: newValue)
    }
  }

  /// I think this and the below (that transforms both axes)
  /// just allow the caller to hop in and  'do some stuff' to
  /// the values, before creating a new size from them.
  public func adjustLength(
    _ axis: Axis2D,
    transform: (CGFloat) -> CGFloat
  ) -> CGSize {
    let transformed = transform(axis.length(fromSize: self))
    return self.adjustLength(axis, newValue: transformed)
  }

  public func adjustLengths(
    transform: (CGFloat, CGFloat) -> (width: CGFloat, height: CGFloat)
  ) -> CGSize {
    let transformed = transform(self.width, self.height)
    return CGSize(width: transformed.width, height: transformed.height)
  }

  public func adjustLengths(by value: CGFloat) -> CGSize {
    return CGSize(self.width * value, self.height * value)
    //    let transformed = transform(self.width, self.height)
    //    return CGSize(width: transformed.width, height: transformed.height)
  }
}
