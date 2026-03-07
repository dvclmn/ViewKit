//
//  IconLiteral.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 31/8/2025.
//

import Foundation

public enum IconLiteral: Sendable, Equatable, Codable, Hashable {
  case emoji(String)
  case emojiComposition(EmojiComposition)
  case symbol(String)
  case customSymbol(CustomSymbol)
}

extension IconLiteral: ExpressibleByStringLiteral {
  /// Have chosen `IconLiteral.symbol` as the
  /// most logical path for a string literal init
  public init(stringLiteral value: String) {
    self = .symbol(value)
  }
}

extension IconLiteral {
  public init(from labelIcon: LabelIcon) {
    switch labelIcon {
      case .symbol(let string): self = .symbol(string)
      case .emoji(let string): self = .emoji(string)
    }
  }
}

extension IconLiteral {
  public static func preset(_ iconPreset: Icons) -> Self {
    self.init(stringLiteral: iconPreset.icon)
  }

  public var toString: String {
    switch self {
      case .emoji(let string): string
      case .emojiComposition(let comp): comp.emoji.map(\.emoji.toString).joined("")
      case .symbol(let string): string
      case .customSymbol(let symbol): symbol.reference
    }
  }

  public var isEmoji: Bool {
    if case .emoji = self {
      return true
    }
    return false
  }

  public var isEmojiComposition: Bool {
    if case .emojiComposition = self {
      return true
    }
    return false
  }

  public var isSymbol: Bool {
    if case .symbol = self {
      return true
    }
    return false
  }

  public var isCustomSymbol: Bool {
    if case .customSymbol = self {
      return true
    }
    return false
  }

}
