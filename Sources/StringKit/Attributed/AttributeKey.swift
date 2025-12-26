//
//  Attributed.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 20/11/2025.
//

import AppKit
import EnumMacros
import SharedHelpers

public struct TextAttributes {
  private var storage: [NSAttributedString.Key: Any]

  public init() {
    self.storage = [:]
  }
}
extension TextAttributes {
  public subscript<Value>(key: AttributeKey<Value>) -> Value? {
    get {
      storage[key.nsKey] as? Value
    }
    set {
      storage[key.nsKey] = newValue
    }
  }
  public var toNSAttributes: NSTextAttributes {
    self.storage
  }
}

public struct AttributeKey<Value>: Sendable, Hashable {
  let nsKey: NSAttributedString.Key
}

extension AttributeKey {
  public static var foregroundColor: AttributeKey<NSColor> { .init(nsKey: .foregroundColor) }
  public static var font: AttributeKey<NSFont> { .init(nsKey: .font) }
  public static var fontTraits: AttributeKey<FontTraits> { .init(nsKey: .fontTraits) }
  public static var codeBackground: AttributeKey<CodeBackground> { .init(nsKey: .codeBackground) }
}

/// Adding all custom keys from any old app here for now, which isn't
/// great for sep. of concerns, but there are also not many apps using these,
/// and makes it a lot easier in this single enum for now, rather than protocol etc
extension String {
  public static var fontTraitsKey: String { "fontTraits" }
  public static var codeBackgroundKey: String { "codeBackground" }
  public static var debugKey: String { "debug" }

}
extension NSAttributedString.Key {
  public static let fontTraits = NSAttributedString.Key(String.fontTraitsKey)
  public static let codeBackground = NSAttributedString.Key(String.codeBackgroundKey)
  public static let debug = NSAttributedString.Key(String.debugKey)
}

/// Made as a slightly more type safe alternative to
/// `[NSAttributedString.Key: Any]`
@Optinits
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
  case debug(String)  // Attach a debug note
  case fontTraits(FontTraits)
  case codeBackground(CodeBackground)
}

extension AnyAttributeKey {

  //  public subscript(key: Self) ->

  public var key: NSAttributedString.Key {
    switch self {
      case .fore: .foregroundColor
      case .font: .font
      case .fontTraits: .fontTraits
      case .codeBackground: .codeBackground
      case .bg: .backgroundColor
      case .strikeColour: .strikethroughColor
      case .strikeStyle: .strikethroughStyle
      /// Or custom, for this, not sure yet
      case .blockIntent: .presentationIntentAttributeName
      case .attachment: .attachment
      case .debug: .debug
    }
  }

  /// Returns `self` as a single-attribute `[NSAttributedString.Key: Any]`
  public var toTextAttribute: NSTextAttributes { [key: value] }

  public var value: Any {
    switch self {
      case .fore(let v): v
      case .font(let v): v
      case .fontTraits(let v): v
      case .codeBackground(let v): v
      case .bg(let v): v
      case .strikeColour(let v): v
      case .strikeStyle(let v): v
      case .blockIntent(let v): v
      case .attachment(let v): v
      case .debug(let v): v
    }
  }
}

extension AnyAttributeKey {
  public static func colour(_ colour: NSColor) -> Self {
    .fore(colour)
  }
  //  public static func bold(_ font: NSFont) -> Self { .font(font) }

}

//extension TextAttributes {
//  self.
//}
