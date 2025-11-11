//
//  Dict+Helpers.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 11/11/2025.
//

extension Box {
  static func reduce<Key: Hashable, Value>(_ dicts: [Dictionary<Key, Value>]) -> Dictionary<Key, Value> {
//    dicts.reduce(into: [:]) { $0.merge($1) { _, new in new } }
    
    dicts.reduce(into: [:]) { partial, dict in
      partial.merge(dict) { current, new in
        new
      }
    }
  }
  
//  static func merge<Key: Hashable, Value>(
//    _ dictA: Dictionary<Key, Value>,
//    _ dictB: Dictionary<Key, Value>
//  ) -> Dictionary<Key, Value> {
//    
//  }
  
//  static func dict<S>(_ items: S) -> Dictionary<S.Element> where S : Sequence, S.Element == (Key, Value)
}
