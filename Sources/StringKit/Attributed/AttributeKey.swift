//
//  Attributed.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 20/11/2025.
//

import AppKit
import EnumMacros
import SharedHelpers

extension NSAttributedString.Key {
  public static let fontTraits = NSAttributedString.Key("fontTraits")
  public static let debug = NSAttributedString.Key("debug")
}

extension NSFontDescriptor.SymbolicTraits: @retroactive Hashable {}

/// Made as a slightly more type safe alternative to
/// `[NSAttributedString.Key: Any]`
@Optinits
public enum AttributeKey: Hashable {
  case fore(NSColor)
  case font(NSFont)
  case fontTraits(FontTraits)
  //  case fontTraits(NSFontDescriptor.SymbolicTraits, current: NSFont)
  case bg(NSColor)
  case strikeColour(NSColor)
  case strikeStyle(NSUnderlineStyle)
  case blockIntent(Bool)
  // See https://developer.apple.com/documentation/appkit/nstextattachmentviewprovider
  // For using an NSView as attachment
  case attachment(NSTextAttachment)
  case debug(String)  // Attach a debug note
  //  case blockIntent(NSPresentationIntent)
}

extension AttributeKey {

  ///
  private var key: NSAttributedString.Key {
    switch self {
      case .fore: .foregroundColor
      case .font: .font
      case .fontTraits: .fontTraits
      case .bg: .backgroundColor
      case .strikeColour: .strikethroughColor
      case .strikeStyle: .strikethroughStyle
      /// Or custom, for this, not sure yet
      case .blockIntent: .presentationIntentAttributeName
      case .attachment: .attachment
      case .debug: .debug
    }
  }

  /// A single-attribute dictionary. WIll return an empty dict
  /// if self is `.fontTrait`, as this isn't compatible.
  public var attribute: TextAttributes { [key: value] }

  public var value: Any {
    switch self {
      case .fore(let v): v
      case .font(let v): v
      case .fontTraits(let v): v
      case .bg(let v): v
      case .strikeColour(let v): v
      case .strikeStyle(let v): v
      case .blockIntent(let v): v
      case .attachment(let v): v
      case .debug(let v): v
    }
  }

  /// Mutates an existing attribute set.
  /// Will have no effect if self is `.fontTrait`
  public func update(
    _ attributes: inout TextAttributes,
  ) {
    switch self {
      case .fontTraits(_, _):

      default:
        attributes[key] = self.value
    }

    if let key {
      /// Run for conventional keys (all except `fontTraits`)
      attributes[key] = self.value

    } else {
      /// Run for `fontTraits`

      let newFont = constructFont(from: attributes)
      attributes[.font] = newFont
    }
  }

}

extension AttributeKey {
  public static func colour(_ colour: NSColor) -> Self {
    .fore(colour)
  }
  //  public static func bold(_ font: NSFont) -> Self { .font(font) }

}
