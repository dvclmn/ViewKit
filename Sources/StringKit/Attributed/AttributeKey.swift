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
    
    self = switch anyKey {
      case .fore: Self<NSColor>.foregroundColor
      case .font: Self<NSFont>.font
      case .fontTraits: Self<FontTraits>.fontTraits
      case .codeBackground: Self<CodeBackground>.codeBackground
      default: return nil
    }
  }
}

extension AttributeKey {
  public static var foregroundColor: AttributeKey<NSColor> { .init(nsKey: .foregroundColor) }
  public static var font: AttributeKey<NSFont> { .init(nsKey: .font) }
  public static var fontTraits: AttributeKey<FontTraits> { .init(nsKey: .fontTraits) }
  public static var codeBackground: AttributeKey<CodeBackground> { .init(nsKey: .codeBackground) }
}
