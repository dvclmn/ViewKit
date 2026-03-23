//
//  ComponentSeparator.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 23/2/2026.
//

public enum ComponentSeparator: Sendable, Equatable {
  case space
  case none
  case custom(String)

  public static let comma: Self = .custom(", ")
  public static let dimensions: Self = .custom(" x ")
  public static let colon: Self = .custom(": ")
  
}

extension ComponentSeparator {
  public var toString: String? {
    switch self {
      case .space: " "
      case .none: nil
      case .custom(let string): string
    }
  }
}



