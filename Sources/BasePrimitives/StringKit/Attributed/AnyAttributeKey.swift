//
//  Attributed.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 20/11/2025.
//

import AppKit
import EnumMacros


/// Made as a slightly more type safe alternative to
/// `[NSAttributedString.Key: Any]`
/// An exhaustive, compile-time switchable list of
/// all attributes that I care about
@Optinits
@MetaEnum
public enum AnyAttributeKey: Hashable {

  /// System keys
  case foreground(NSColor)
  case font(NSFont)
  case background(NSColor)
  case strikeColour(NSColor)
  case strikeStyle(NSUnderlineStyle)
//  case blockIntent(Bool)

  /// See https://developer.apple.com/documentation/appkit/nstextattachmentviewprovider
  /// for info on using an NSView as attachment
  case attachment(NSTextAttachment)

  /// Custom keys
  case fontTraits(FontTraits)
}

extension AnyAttributeKey.Meta {
  public var key: NSAttributedString.Key {
    switch self {
      case .foreground: .foregroundColor
      case .font: .font
      case .fontTraits: .fontTraits
      case .background: .backgroundColor
      case .strikeColour: .strikethroughColor
      case .strikeStyle: .strikethroughStyle
//      case .blockIntent: .presentationIntentAttributeName
      case .attachment: .attachment
    }
  }
}

extension AnyAttributeKey {

  /// Returns `self` as a single-attribute `[NSAttributedString.Key: Any]`
  public var toTextAttribute: NSTextAttributes {
    let key = Self.Meta(self).key
    return [key: value]
  }

  public var value: Any {
    switch self {
      case .foreground(let v): v
      case .font(let v): v
      case .fontTraits(let v): v
      case .background(let v): v
      case .strikeColour(let v): v
      case .strikeStyle(let v): v
//      case .blockIntent(let v): v
      case .attachment(let v): v
    }
  }

  /// Produces a typed AttributeKey/Value pair if possible
//  public func toTypedKeyValue() -> (anyKey: Any, value: Any) {
    
    
//    switch self {
//      case .foreground(let color): (AttributeKey<NSColor>.foregroundColor, color)
//      case .font(let font): (AttributeKey<NSFont>.font, font)
//      case .fontTraits(let traits): (AttributeKey<FontTraits>.fontTraits, traits)
//      case .background(let color): (AttributeKey<NSColor>.background, color)
//      case .strikeColour(let color): (AttributeKey<NSColor>.textBackgroundColor, color)
//      case .strikeStyle(let style):
//        (AttributeKey<NSNumber>.init(rawValue: "NSUnderlineStyle"), NSNumber(value: style.rawValue))
//      case .blockIntent(let bool): (AttributeKey<Bool>.init(rawValue: "NSPresentationIntent"), bool)
//      case .attachment(let attachment):
//        (AttributeKey<NSTextAttachment>.init(data: nil, ofType: nil), attachment)
//    //      default: (self.key, self.value)
//    }
//  }
}

// MARK: - Convenient helpers
extension AnyAttributeKey {
  public static func colour(_ colour: NSColor) -> Self {
    .foreground(colour)
  }
}
