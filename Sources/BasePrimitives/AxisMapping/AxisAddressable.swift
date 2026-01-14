//
//  AxisAddressable.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 15/12/2025.
//

import Foundation

/// Note: this requires that conforming types have mutable (var) properties
public protocol AxisKeyPathCompatible {
  associatedtype Component

  /// The KeyPath to the first storage slot (e.g., .width, .x, .column)
  static var primaryKey: WritableKeyPath<Self, Component> { get }

  /// The KeyPath to the second storage slot (e.g., .height, .y, .row)
  static var secondaryKey: WritableKeyPath<Self, Component> { get }
}

extension AxisKeyPathCompatible {
  public func value(
    along axis: GridAxis,
    mapping: AxisMapping = .default,
  ) -> Component {
    /// Resolve which KeyPath to use based on the axis and the mapping
    let keyPath = mapping.resolve(
      primary: Self.primaryKey,
      secondary: Self.secondaryKey,
      for: axis
    )
    return self[keyPath: keyPath]
  }

  public func setting(
    _ newValue: Component,
    along axis: GridAxis,
    mapping: AxisMapping = .identity
  ) -> Self {
    var copy = self
    let keyPath = mapping.resolve(
      primary: Self.primaryKey,
      secondary: Self.secondaryKey,
      for: axis
    )
    copy[keyPath: keyPath] = newValue
    return copy
  }
}

//public protocol AxisCompatible {
//  associatedtype Component
//
//  /// Returns (width, height), (x, y), or (col, row)
//  var naturalComponents: (primary: Component, secondary: Component) { get }
//
//  /// Creates a new instance from natural components
//  static func create(primary: Component, secondary: Component) -> Self
//}
//
//extension AxisCompatible {
//  public func value(along axis: Axis2D, mapping: AxisMapping = .identity) -> Component {
//    let components = self.naturalComponents
//    return mapping.select(primary: components.primary, secondary: components.secondary, for: axis)
//  }
//
//  public func setting(_ newValue: Component, along axis: Axis2D, mapping: AxisMapping = .identity) -> Self {
//    let current = self.naturalComponents
//
//    // Use the mapping to decide if 'newValue' replaces primary or secondary
//    let h = mapping.select(primary: newValue, secondary: current.secondary, for: .horizontal)
//    let v = mapping.select(primary: current.primary, secondary: newValue, for: .vertical)
//
//    let final = mapping.pair(h: h, v: v)
//    return Self.create(primary: final.primary, secondary: final.secondary)
//  }
//}

//public protocol AxisAddressable {
//  associatedtype Component
//
//  /// The first storage component (e.g., width, x, column)
//  var identityComponent: Component { get set }
//
//  /// The second storage component (e.g., height, y, row)
//  var transposedComponent: Component { get set }
//
//  static var zero: Self { get }
//}

//extension AxisAddressable {
//  /// Unified getter for any axis-addressable type
//  public func value(
//    along axis: Axis2D,
//    mapping: AxisMapping = .default
//  ) -> Component {
//    switch (axis, mapping) {
//      case (.horizontal, .identity), (.vertical, .transposed):
//        return identityComponent
//      case (.vertical, .identity), (.horizontal, .transposed):
//        return transposedComponent
//    }
//  }
//
//  /// Unified setter that returns a new instance
//  public func setting(
//    _ value: Component,
//    along axis: Axis2D,
//    mapping: AxisMapping = .default
//  ) -> Self {
//    var copy = self
//    switch (axis, mapping) {
//      case (.horizontal, .identity), (.vertical, .transposed):
//        copy.identityComponent = value
//      case (.vertical, .identity), (.horizontal, .transposed):
//        copy.transposedComponent = value
//    }
//    return copy
//  }
//}

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
