//
//  AxisAddressable.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 15/12/2025.
//

import Foundation

/// Note: this requires that conforming types have mutable (var) properties
public protocol AxisKeyPathWritable: AxisKeyPathReadable {
  associatedtype Component

  /// Path to the first storage slot (e.g., .width, .x, .column)
  static var primaryKey: WritableKeyPath<Self, Component> { get }

  /// Path to the second storage slot (e.g., .height, .y, .row)
  static var secondaryKey: WritableKeyPath<Self, Component> { get }
}

extension AxisKeyPathWritable {
  public static var primaryKey: KeyPath<Self, Component> { primaryKey }
  public static var secondaryKey: KeyPath<Self, Component> { secondaryKey }
}

public protocol AxisKeyPathReadable {
  associatedtype Component

  /// Path to the first storage slot (e.g., .width, .x, .column)
  static var primaryKey: KeyPath<Self, Component> { get }

  /// Path to the second storage slot (e.g., .height, .y, .row)
  static var secondaryKey: KeyPath<Self, Component> { get }
}

extension AxisKeyPathReadable {
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
}

extension AxisKeyPathWritable {
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
