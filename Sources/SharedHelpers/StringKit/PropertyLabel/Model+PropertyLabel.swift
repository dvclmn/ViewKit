//
//  Model+DisplayPair.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 10/7/2025.
//

import EnumMacros
import Foundation

/// A property label is aimed at expressing the
/// string representaiton for a property, such as
/// "X" and "Y" properties for CGPoint. Or "width"
/// and "height" for CGSize.
///
/// With the option for a default version and a short version.
/// E.g. default: "width", abbreviated: "W"
public struct PropertyLabel {

  /// The standard / more verbose representation,
  /// e.g. `Width` for `CGSize`
  let label: String

  /// A more concise version, such as `W` instead of `Width`
  let abbreviated: String?

  /// Text separating the property's label from it's float value
  /// E.g. the colon in `Width: ` or `X: `
  let separator: String

  public init(
    _ label: String,
    abbreviated: String? = nil,
    separator: String = ": "
  ) {
    self.label = label
    self.abbreviated = abbreviated
    self.separator = separator
  }
}

extension PropertyLabel: ExpressibleByStringLiteral {
  public init(stringLiteral value: String) {
    self.init(value)
  }
}

extension PropertyLabel {

  func labelText(style: Self.Style) -> String? {
    switch style {
      case .none: nil
      case .standard: label

      /// Falls back to standard if `abbreviated` is `nil`
      case .abbreviated: abbreviated ?? label
    }
  }

  func separatorText(using format: FloatDisplayFormat) -> String? {
    let shouldRenderSep: Bool =
      format.separatorVisibility.contains(.propertyLabel)
      && format.labelStyle != .none
    return shouldRenderSep ? separator : nil
  }

  public func stringValue(using format: FloatDisplayFormat) -> String? {
    let text = labelText(style: format.labelStyle)
    let separator = separatorText(using: format)
    return [text, separator].compactMap(\.self).joined("")
  }
}
