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
    let nsKey: NSAttributedString.Key? =
      switch anyKey {
        case .fore: .foregroundColor
        case .font: .font
        case .fontTraits: .fontTraits
        default: nil
      }
    guard let nsKey else { return nil }
    self.init(nsKey: nsKey)
  }
}

extension AttributeKey {
  public static var foregroundColor: AttributeKey<NSColor> { .init(nsKey: .foregroundColor) }
  public static var font: AttributeKey<NSFont> { .init(nsKey: .font) }
  public static var fontTraits: AttributeKey<FontTraits> { .init(nsKey: .fontTraits) }
}
