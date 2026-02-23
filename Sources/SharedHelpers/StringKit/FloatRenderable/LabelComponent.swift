//
//  FloatGroup.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 4/10/2025.
//

import Foundation

/// A component is a key+value pair, where the
/// key is the property's text label ``PropertyLabel``,
/// and the value is the floating point value of this property
public struct LabelComponent {
  /// E.g. `Width`, or `X`. May include a separator,
  /// such as the colon here in `Height:`
  public let label: PropertyLabel

  /// The value corresponding to the label
  public let value: any FloatRenderable

  public init(
    _ label: PropertyLabel,
    value: any FloatRenderable
  ) {
    self.label = label
    self.value = value
  }
}
