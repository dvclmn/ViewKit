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
  case fontTraits(NSFontDescriptor.SymbolicTraits, current: NSFont)
  case bg(NSColor)
  case strikeColour(NSColor)
  case strikeStyle(NSUnderlineStyle)
  case blockIntent(Bool)
  case debug(String)  // Attach a debug note
  // See https://developer.apple.com/documentation/appkit/nstextattachmentviewprovider
  // For using an NSView as attachment
  case attachment(NSTextAttachment)
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
  public var attribute: TextAttributes {
    //    guard let key else { return [:] }
    return [key: value]
  }

  public var value: Any {
    switch self {
      case .fore(let value): value
      case .font(let value): value
      case .fontTraits(let traits, _): traits
      case .bg(let value): value
      case .strikeColour(let value): value
      case .strikeStyle(let value): value
      case .blockIntent(let value): value
      case .attachment(let value): value
      case .debug(let value): value
    }
  }

  /// Mutates an existing attribute set.
  /// Will have no effect if self is `.fontTrait`
  public func update(
    _ attributes: inout TextAttributes,
  ) {
    switch self {
      case .fontTraits(_, _):
        
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

  private func constructFont(from attributes: TextAttributes) -> NSFont? {

    guard let traitData else {
      print("No trait data found, this should only run for `self.fontTraits`")
      return nil
    }

    print("Let's check attributes first: \(attributes.names)")

    let traits = traitData.0
    let currentFont = traitData.1
    //    guard let fontAttr = attributes[.font] else {
    //      print("No attribute found for `.font`.")
    //      return nil
    //    }

    //    guard let fontValue = fontAttr as? NSFont else {
    //      DebugString {
    //        "Couldn't cast to NSFont, unable to build traits `\(traits.prettyDescription)`"
    //        Labeled("Attributes", value: attributes.names)
    //
    //      }
    //
    //      return nil
    //    }
    let size = currentFont.pointSize
    let desc = currentFont.fontDescriptor.withSymbolicTraits(traits)
    let newFont = NSFont(descriptor: desc, size: size)
    return newFont
  }

  private var traitData: (NSFontDescriptor.SymbolicTraits, NSFont)? {
    switch self {
      case .fontTraits(let traits, let font): (traits, font)
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
