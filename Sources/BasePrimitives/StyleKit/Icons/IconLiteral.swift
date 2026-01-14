//
//  IconLiteral.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 31/8/2025.
//

import Foundation

public enum IconLiteral: Sendable, Equatable, Codable, Hashable {
  case emoji(String)
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
  public static func fromPreset(_ iconPreset: Icons) -> Self {
    self.init(stringLiteral: iconPreset.icon)
  }
  
  public var toString: String {
    switch self {
      case .emoji(let string):
        return string
      case .symbol(let string):
        return string
      case .customSymbol(let symbol):
        return symbol.reference
    }
  }
}
