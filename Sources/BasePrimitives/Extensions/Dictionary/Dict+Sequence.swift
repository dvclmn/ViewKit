//
//  Sequence+Dict.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 12/11/2025.
//

// MARK: - Dictionary operations
extension Sequence {

  public func groupedDictionary<K: Hashable>(
    by keyPath: KeyPath<Element, K>
  ) -> [K: [Element]] {
    Dictionary(grouping: self, by: { $0[keyPath: keyPath] })
  }

  /// Safely creates a dictionary from this sequence
  public func toDictionary<Key: Hashable, Value>(
    key: KeyPath<Element, Key>,
    value: KeyPath<Element, Value>,
    keeping strategy: MergeStrategy<Key, Value> = .first
  ) -> [Key: Value] {
    reduce(into: [:]) { result, element in
      let k = element[keyPath: key]
      let v = element[keyPath: value]
      result.merge([k: v], uniquingKeysWith: strategy.function)
    }
  }

  /// Convenience for when the element itself is the value
  public func toDictionary<Key: Hashable>(
    key: KeyPath<Element, Key>
  ) -> [Key: Element] {
    toDictionary(key: key, value: \.self)
  }
}
