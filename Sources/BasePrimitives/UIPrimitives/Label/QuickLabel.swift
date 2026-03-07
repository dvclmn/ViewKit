//
//  QuickLabel.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 26/5/2025.
//

import SwiftUI

#warning(
  "I should consider retiring this, and trying a more SwiftUI shape, which is accept a String/LocalisedStringKey as a dead-simple text title (no Label, icon etc). And then have an overload for a Label (which is richer — progressive disclosure). Which could then lean into IconLiteral, EmojiComposition etc"
)
public struct QuickLabel: Sendable, Codable, Equatable, Hashable {
  public var text: String
  public let icon: IconLiteral?
  public let role: ActionRole?
}

extension QuickLabel {

  public init(
    _ text: String,
    icon: IconLiteral? = nil,
    role: ActionRole? = nil
  ) {
    self.text = text
    self.icon = icon
    self.role = role
  }

  /// This doesn't have a default of `nil` for `symbol`,
  /// to disambiguate from ``QuickLabel/init(_:icon:role:)``
  public init(
    _ text: String,
    symbol symbolString: String?,
    role: ActionRole? = nil
  ) {
    self.init(
      text,
      icon: symbolString.map { IconLiteral.symbol($0) },
      role: role
    )
  }
}

extension QuickLabel: ExpressibleByStringLiteral {
  public init(stringLiteral value: String) {
    self.init(value)
  }
}

extension QuickLabel: CustomStringConvertible {
  public var description: String {
    return "QuickLabel[\"\(text)\", icon: \"\(icon?.toString ?? "")\"]"
  }
}
