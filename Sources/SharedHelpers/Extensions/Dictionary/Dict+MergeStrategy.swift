//
//  Dict+MergeStrategy.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 12/11/2025.
//


public enum MergeStrategy<Key, Value> {
  case keepFirst
  case keepLast
  case custom((Value, Value) -> Value)
  
  var function: (Value, Value) -> Value {
    switch self {
      case .keepFirst: { first, _ in first }
      case .keepLast: { _, last in last }
      case .custom(let f): f
    }
  }
}
