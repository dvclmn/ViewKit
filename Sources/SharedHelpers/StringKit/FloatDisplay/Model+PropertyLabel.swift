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
  public func stringValue(
    from style: PropertyLabel.Style,
    hasSeparator: Bool = true
  ) -> String? {
    let labelText: String? =
      switch style {
        case .none: nil
        case .standard: self.label
        case .abbreviated: self.abbreviated
      }
    let shouldRenderSep: Bool = hasSeparator && style != .none
    let separator: String? = shouldRenderSep ? self.separator : nil
    return [labelText, separator].compactMap(\.self).joined()
  }

  @CaseDetection
  public enum Style: Equatable {
    case none
    case standard
    case abbreviated
  }
}
