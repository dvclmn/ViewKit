//
//  DisplayComponent.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 3/10/2025.
//

import Foundation

// MARK: - Single Component

/// A key-value pair, for display floats with labels
extension FloatDisplay {
}
public struct FloatComponent: LabeledComponent {
  typealias Value = FloatString
  public let label: PropertyLabel
  let value: Value
  
  public init(
    _ label: PropertyLabel,
    value: Value,
  ) {
    self.label = label
    self.value = value
  }
}
