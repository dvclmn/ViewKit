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
  public struct Component {
    let label: PropertyLabel
    let value: any DisplayString
    
    public init(
      _ label: PropertyLabel,
      value: any DisplayString,
    ) {
      self.label = label
      self.value = value
    }
  }
}
