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
@MetaEnum
public enum AnyAttributeKey: Hashable {

  /// System keys
  case fore(NSColor)
  case font(NSFont)
  case bg(NSColor)
  case strikeColour(NSColor)
  case strikeStyle(NSUnderlineStyle)
  case blockIntent(Bool)

  /// See https://developer.apple.com/documentation/appkit/nstextattachmentviewprovider
  /// for info on using an NSView as attachment
  case attachment(NSTextAttachment)

  /// Custom keys
  case fontTraits(FontTraits)
}

extension AnyAttributeKey {

  public var key: NSAttributedString.Key {
    switch self {
      case .fore: .foregroundColor
      case .font: .font
      case .fontTraits: .fontTraits
      case .bg: .backgroundColor
      case .strikeColour: .strikethroughColor
      case .strikeStyle: .strikethroughStyle
      case .blockIntent: .presentationIntentAttributeName
      case .attachment: .attachment
    }
  }

  /// Returns `self` as a single-attribute `[NSAttributedString.Key: Any]`
  public var toTextAttribute: NSTextAttributes { [key: value] }

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
    }
  }
}

// MARK: - Convenient helpers
extension AnyAttributeKey {
  public static func colour(_ colour: NSColor) -> Self {
    .fore(colour)
  }
}
