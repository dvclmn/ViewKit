//
//  Attributed.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 20/11/2025.
//

import AppKit

/// Made as a slightly more type safe alternative to
/// `[NSAttributedString.Key: Any]`
public enum Attribute {
  case foreground(NSColor)
  case font(NSFont)
  case background(NSColor)
  case strikeColour(NSColor)
  case strikeStyle(NSUnderlineStyle)

  var key: NSAttributedString.Key {
    switch self {
      case .foreground: .foregroundColor
      case .font: .font
      case .background: .backgroundColor
      case .strikeColour: .strikethroughColor
      case .strikeStyle: .strikethroughStyle
    }
  }

  /// A single-attribute dictionary
  public var attribute: TextAttributes {
    switch self {
      case .foreground(let nSColor): [self.key: nSColor]
      case .font(let nSFont): [self.key: nSFont]
      case .background(let nSColor): [self.key: nSColor]
      case .strikeColour(let nSColor): [self.key: nSColor]
      case .strikeStyle(let style): [self.key: style]
    }
  }
  
  public var rawValue: Any {
    switch self {
      case .foreground(let c): c
      case .font(let f): f
      case .background(let c): c
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
  public static func colour(_ colour: NSColor) -> Self { .foreground(colour) }
  public static func bold(_ font: NSFont) -> Self { .font(font) }
}
