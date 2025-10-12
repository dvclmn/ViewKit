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
