//
//  Attributed.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 20/11/2025.
//

import AppKit
import SharedHelpers
import EnumMacros

/// Made as a slightly more type safe alternative to
/// `[NSAttributedString.Key: Any]`

@Optinits
public enum Attribute {
  case foreground(NSColor)
  case font(NSFont)
//  case fontTraits(NSFontDescriptor.SymbolicTraits)
  case background(NSColor)
  case strikeColour(NSColor)
  case strikeStyle(NSUnderlineStyle)
  
//  public init?(foreground: NSColor?) {
//    guard let foreground else { return nil }
//    self = .foreground(foreground)
//  }
}

extension Attribute {
  
  var key: NSAttributedString.Key {
    switch self {
      case .foreground: .foregroundColor
//      case .fontTraits: .font
      case .font: .font
      case .background: .backgroundColor
      case .strikeColour: .strikethroughColor
      case .strikeStyle: .strikethroughStyle
    }
  }

  /// A single-attribute dictionary
  public var attribute: TextAttributes { [key: rawValue] }
  //  public var attribute: TextAttributes {
  //    switch self {
  //      case .foreground(let nSColor): [self.key: nSColor]
  //      case .font(let nSFont): [self.key: nSFont]
  //      case .background(let nSColor): [self.key: nSColor]
  //      case .strikeColour(let nSColor): [self.key: nSColor]
  //      case .strikeStyle(let style): [self.key: style]
  //    }
  //  }

  public var rawValue: Any {
    switch self {
      case .foreground(let c): c
//      case .fontTraits(let traits): NSFont. NSFont(descriptor: NSFontDescriptor.), textTransform: <#T##AffineTransform?#>)
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
  public static func colour(_ colour: NSColor) -> Self {
    .foreground(colour)
  }
  public static func bold(_ font: NSFont) -> Self { .font(font) }
  
}
