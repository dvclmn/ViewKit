//
//  Dict+MergeStrategy.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 12/11/2025.
//

public enum MergeStrategy<Key, Value> {
  case first
  case last
  case custom((Value, Value) -> Value)

  var function: (Value, Value) -> Value {
    switch self {
      case .first: { first, _ in first }
      case .last: { _, last in last }
      case .custom(let f): f
    }
  }
}
