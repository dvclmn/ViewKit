//
//  PropertySeparator.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 23/2/2026.
//

public enum PropertySeparator: Sendable, Equatable {
  case colon
  case custom(String)
  case none
}

extension PropertySeparator {
  var toString: String? {
    switch self {
      case .colon: ": "
      case .custom(let str): str
      case .none: nil
    }
  }
}
