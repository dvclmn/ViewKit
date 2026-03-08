//
//  ComponentSeparator.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 23/2/2026.
//

public enum ComponentDelimiter: Sendable, Equatable {
  case space
  case none
  case custom(String)

  public static let comma: Self = .custom(", ")
  public static let dimensions: Self = .custom(" x ")
}

extension ComponentDelimiter {
  public var toString: String? {
    switch self {
      case .space: " "
      case .none: nil
      case .custom(let string): string
    }
  }
}


