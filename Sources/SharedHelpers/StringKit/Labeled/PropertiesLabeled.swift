//
//  LabeledComponent.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 12/10/2025.
//

import Foundation

public protocol PropertiesLabeled {
//  associatedtype Value: StringConvertible

  /// A component is a key+value pair, where the
  /// key is the property's text label ``PropertyLabel``,
  /// and the value is the floating point value of that property,
  /// conforming to ``StringConvertible``.
  ///
  /// E.g. `Width` paired with `10.5`
  ///
  /// Note: the ``PropertyLabel`` includes a trailing
  /// separator, delimiting the Label and Value. This is different
  /// to the below ``PropertiesLabeled/separator``.
  var components: [LabelComponent] { get }
  
  /// Text separating each Label+Value pairing.
  /// E.g. the comma `,` in `X: 10, Y: -20`
  var separator: String { get }
//  var separators: Separators { get }
//  var style: PropertyLabel.Style { get }
}

public struct LabelComponent {
  public let label: PropertyLabel
  public let value: any FloatString

  public init(
    _ label: PropertyLabel,
    value: any FloatString
  ) {
    self.label = label
    self.value = value
  }
}
