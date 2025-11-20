//
//  Attributed.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 20/11/2025.
//

import AppKit
import EnumMacros
import SharedHelpers

/// Made as a slightly more type safe alternative to
/// `[NSAttributedString.Key: Any]`

@Optinits
public enum Attribute {
  case fore(NSColor)
  case font(NSFont)
  case bg(NSColor)
  case strikeColour(NSColor)
  case strikeStyle(NSUnderlineStyle)

}

extension Attribute {

  var key: NSAttributedString.Key {
    switch self {
      case .fore: .foregroundColor
      case .font: .font
      case .bg: .backgroundColor
      case .strikeColour: .strikethroughColor
      case .strikeStyle: .strikethroughStyle
    }
  }

  /// A single-attribute dictionary
  public var attribute: TextAttributes { [key: rawValue] }

  public var rawValue: Any {
    switch self {
      case .fore(let c): c
      case .font(let f): f
      case .bg(let c): c
      case .strikeColour(let c): c
      case .strikeStyle(let s): s.rawValue
    }
  }

  /// Mutates an existing attribute set
  public func update(_ attributes: inout TextAttributes) {
    attributes[self.key] = self.rawValue
  }
}

extension Attribute {
  public static func colour(_ colour: NSColor) -> Self {
    .fore(colour)
  }
  public static func bold(_ font: NSFont) -> Self { .font(font) }

}
