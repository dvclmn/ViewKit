//
//  DisplayComponent.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 3/10/2025.
//

import Foundation

// MARK: - Single Component

/// A key-value pair, for display floats with labels
public struct Component {
  let label: PropertyLabel
  let value: any FloatDisplay

  public init(
    _ label: PropertyLabel,
    value: any FloatDisplay,
  ) {
    self.label = label
    self.value = value
  }
}

public struct Separators {

  /// Seperates the `key` from the `value`
  /// E.g. the `", "` from `X: 10, Y: -20`
  ///
  /// Who handles this separator?
  /// The type that holds onto both a `PropertyLabel`
  /// and a `value: any StringConvertible`.
  /// This is often a single `Component`
  let propertyLabel: String

  /// Seperates two (or more) `key-value` pairs
  /// E.g. the `" x "` from `800 x 600px`
  /// Or the `", "` from `X: 10, Y: -20`
  ///
  /// Who handles this separator?
  /// Whoever handles joining multiple `Component`s
  /// This is often a build expression?
  let component: String

  public init(
    propertyLabel: String,
    component: String
  ) {
    self.propertyLabel = propertyLabel
    self.component = component
  }
}
