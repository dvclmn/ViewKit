//
//  IconLiteral.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 31/8/2025.
//

import Foundation
import SampleBuilder
import BasePrimitives

@SampleBuilder(numberOfItems: 3, dataGeneratorType: .random)
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
  public static func preset(_ iconPreset: Icons) -> Self {
    self.init(stringLiteral: iconPreset.icon)
  }

  public var toString: String {
    switch self {
      case .emoji(let string): string
      case .symbol(let string): string
      case .customSymbol(let symbol): symbol.reference
    }
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
