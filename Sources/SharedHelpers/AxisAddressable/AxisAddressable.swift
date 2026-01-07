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
  var primaryComponent: Component { get set }
  /// The second storage component (e.g., height, y, row)
  var secondaryComponent: Component { get set }
}

extension AxisAddressable {
  /// Unified getter for any axis-addressable type
  public func value(along axis: Axis2D, mapping: AxisMapping = .primaryIsHorizontal) -> Component {
    switch (axis, mapping) {
      case (.horizontal, .primaryIsHorizontal), (.vertical, .primaryIsVertical):
        return primaryComponent
      case (.vertical, .primaryIsHorizontal), (.horizontal, .primaryIsVertical):
        return secondaryComponent
    }
  }
  
  /// Unified setter that returns a new instance
  public func setting(_ value: Component, along axis: Axis2D, mapping: AxisMapping = .primaryIsHorizontal) -> Self {
    var copy = self
    switch (axis, mapping) {
      case (.horizontal, .primaryIsHorizontal), (.vertical, .primaryIsVertical):
        copy.primaryComponent = value
      case (.vertical, .primaryIsHorizontal), (.horizontal, .primaryIsVertical):
        copy.secondaryComponent = value
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
