//
//  Attributed.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 20/11/2025.
//

import AppKit
import EnumMacros
import SharedHelpers

extension NSFontDescriptor.SymbolicTraits: @retroactive Hashable {}

/// Made as a slightly more type safe alternative to
/// `[NSAttributedString.Key: Any]`
@Optinits
public enum AttributeKey: Hashable {
  case fore(NSColor)
  case font(NSFont)
  case fontTraits(NSFontDescriptor.SymbolicTraits)
  case bg(NSColor)
  case strikeColour(NSColor)
  case strikeStyle(NSUnderlineStyle)
}

extension AttributeKey {

  private var key: NSAttributedString.Key? {
    switch self {
      case .fore: .foregroundColor
      case .font: .font
      case .fontTraits: nil
      case .bg: .backgroundColor
      case .strikeColour: .strikethroughColor
      case .strikeStyle: .strikethroughStyle
    }
  }

  /// A single-attribute dictionary. WIll return an empty dict
  /// if self is `.fontTrait`, as this isn't compatible.
  public var attribute: TextAttributes {
    guard let key else { return [:] }
    return [key: rawValue]
  }

  public var rawValue: Any {
    switch self {
      case .fore(let value): value
      case .font(let value): value
      case .fontTraits(let value): value
      case .bg(let value): value
      case .strikeColour(let value): value
      case .strikeStyle(let value): value.rawValue
    }
  }

  /// Mutates an existing attribute set.
  /// Will have no effect if self is `.fontTrait`
  public func update(_ attributes: inout TextAttributes) {
    //    if let isFont = attributes[.font] {
    //
    //    }
    //    guard let key else {
    //      //      print("No value for \(self) for `key`, self must be `.fontTrait`")
    //      return
    //    }

    if let key {
      attributes[key] = self.rawValue
    } else {
      let newFont = constructFont(from: attributes)
      attributes[.font] = newFont
    }
  }

  private func constructFont(from attributes: TextAttributes) -> NSFont? {

    guard let traits else {
      print("No traits found, this should only run for `self.fontTraits`")
      return nil
    }

    guard let fontValue = attributes[.font] as? NSFont else {
      print("Couldn't retrieve/cast to NSFont for \(self)")
      return nil
    }
    let size = fontValue.pointSize
    let desc = fontValue.fontDescriptor.withSymbolicTraits(traits)
    let newFont = NSFont(descriptor: desc, size: size)
    return newFont
  }

  private var traits: NSFontDescriptor.SymbolicTraits? {
    switch self {
      case .fontTraits(let traits): traits
      default: nil
    }
  }
}

extension AttributeKey {
  public static func colour(_ colour: NSColor) -> Self {
    .fore(colour)
  }
  //  public static func bold(_ font: NSFont) -> Self { .font(font) }

}
