//
//  Dict+Bool.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 26/1/2026.
//

import Foundation

extension Dictionary {

  /// Toggle a Bool inside each value for a given set of keys,
  /// using the same ToggleStrategy rules as the collection helpers.
  ///
  /// - Parameters:
  ///   - keys:      The subset of keys to affect.
  ///   - keyPath:   The Bool property to mutate inside each Value.
  ///   - default:   A factory to supply a value when a key is missing.
  ///   - strategy:  How to decide the on/off behaviour.
  public mutating func toggleValues(
    for keys: Set<Key>,
    at keyPath: WritableKeyPath<Value, Bool>,
    default defaultValue: (Key) -> Value,
    strategy: ToggleStrategy
  ) {
    /// capture the current states (providing defaults for missing keys)
    let states: [Bool] = keys.map { self[$0, default: defaultValue($0)][keyPath: keyPath] }

    if let target = states.target(for: strategy) {
      // single uniform value
      for k in keys {
        self[k, default: defaultValue(k)][keyPath: keyPath] = target
      }
    } else {
      // invert each individually
      for k in keys {
        self[k, default: defaultValue(k)][keyPath: keyPath].toggle()
      }
    }
  }
}

extension Dictionary where Value == Bool {
  /// Toggles the value for the given key.
  /// If the key does not exist, it's assumed to be `false` and set to `true`.
  @discardableResult
  public mutating func toggleValue(forKey key: Key) -> Bool {
    let newValue = !(self[key] ?? false)
    self[key] = newValue
    return newValue
  }
  //  /// Toggles the value for the given key.
  //  /// If the key does not exist, it's assumed to be `false` and set to `true`.
  //  @discardableResult
  //  public mutating func toggleValue(
  //    forKey key: Key,
  //    fallBack: Bool = false
  //  ) -> Bool {
  //    let newValue = !(self[key] ?? fallBack)
  //    self[key] = newValue
  //    return newValue
  //  }
}
