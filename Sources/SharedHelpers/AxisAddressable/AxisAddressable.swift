//
//  AxisAddressable.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 15/12/2025.
//

import Foundation

public protocol AxisAddressable {
  associatedtype Component

  /// The first storage component (e.g., width, x, column)
  var identityComponent: Component { get set }
  
  /// The second storage component (e.g., height, y, row)
  var transposedComponent: Component { get set }
  
  static var zero: Self { get }
}

extension AxisAddressable {
  /// Unified getter for any axis-addressable type
  public func value(
    along axis: Axis2D,
    mapping: AxisMapping = .default
  ) -> Component {
    switch (axis, mapping) {
      case (.horizontal, .identity), (.vertical, .transposed):
        return identityComponent
      case (.vertical, .identity), (.horizontal, .transposed):
        return transposedComponent
    }
  }

  /// Unified setter that returns a new instance
  public func setting(
    _ value: Component,
    along axis: Axis2D,
    mapping: AxisMapping = .default
  ) -> Self {
    var copy = self
    switch (axis, mapping) {
      case (.horizontal, .identity), (.vertical, .transposed):
        copy.identityComponent = value
      case (.vertical, .identity), (.horizontal, .transposed):
        copy.transposedComponent = value
    }
    return copy
  }
}

//public protocol AxisAddressable {
//
//  associatedtype Value
//
//  func value(along axis: Axis2D, convention: AxisConvention) -> Value
//
//  func setting(
//    _ value: Value,
//    along axis: Axis2D,
//    convention: AxisConvention
//  ) -> Self
//}
//
//public protocol GridAxisAddressable {
//
//  associatedtype Value
//
//  func value(along axis: Axis2D, convention: GridAxisConvention) -> Value
//
//  func setting(
//    _ value: Value,
//    along axis: Axis2D,
//    convention: GridAxisConvention
//  ) -> Self
//}
