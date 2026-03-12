//
//  AttributeKey.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 26/12/2025.
//

import AppKit


public struct AttributeKey<Value>: Sendable, Hashable {
  let nsKey: NSAttributedString.Key
}

extension AttributeKey {
  init?(fromAnyKey anyKey: AnyAttributeKey.Meta) {
    self.init(nsKey: anyKey.key)
  }

  public func toAnyKey(with value: Value) -> AnyAttributeKey? {
    switch nsKey {
      case .foregroundColor:
        guard let color = value as? NSColor else { return nil }
        return .foreground(color)

      case .font:
        guard let font = value as? NSFont else { return nil }
        return .font(font)

      case .fontTraits:
        guard let traits = value as? FontTraits else { return nil }
        return .fontTraits(traits)

      default:
        return nil
    }
  }
}

extension AttributeKey {
  //  public static var foregroundColor: AttributeKey<NSColor> { .init(nsKey: .foregroundColor) }
  //  public static var font: AttributeKey<NSFont> { .init(nsKey: .font) }
  //  public static var fontTraits: AttributeKey<FontTraits> { .init(nsKey: .fontTraits) }

  static func key(for type: AnyAttributeKey.Meta) -> AttributeKey<Value>? {
    let thing: Any =
      switch type {
        case .foreground: AttributeKey<NSColor>(nsKey: .foregroundColor)
        case .font: AttributeKey<NSFont>(nsKey: .font)
        case .fontTraits: AttributeKey<FontTraits>(nsKey: .fontTraits)
        case .background: AttributeKey(nsKey: .backgroundColor)
        case .strikeColour: AttributeKey(nsKey: .strikethroughColor)
        case .strikeStyle: AttributeKey(nsKey: .strikethroughStyle)
        case .attachment: AttributeKey(nsKey: .backgroundColor)
      }

    return thing as? AttributeKey<Value>

  }

}
