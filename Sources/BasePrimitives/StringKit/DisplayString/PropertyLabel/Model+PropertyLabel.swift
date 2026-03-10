//
//  Model+DisplayPair.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 10/7/2025.
//

import Foundation

/// Represents the text label for a property, e.g. "Width" / "W" for `CGSize.width`.
/// Knows nothing about values, separators, or float formatting.
public struct AbbreviableLabel: Sendable {

  /// The standard / more verbose representation, e.g. `Width`
  let label: String

  /// A more concise version, e.g. `W` instead of `Width`
  let abbreviated: String?

  public init(
    _ label: String,
    abbreviated: String? = nil
  ) {
    self.label = label
    self.abbreviated = abbreviated
  }
}

extension AbbreviableLabel: ExpressibleByStringLiteral {
  public init(stringLiteral value: String) {
    self.init(value)
  }
}

extension AbbreviableLabel {

  /// Returns the label text for the given display style, or `nil` for `.none`.
  public func labelText(with style: Self.Style) -> String? {
    switch style {
      case .none: nil
      case .standard: label
      /// Falls back to standard if `abbreviated` is `nil`
      case .abbreviated: abbreviated ?? label
    }
  }
}
