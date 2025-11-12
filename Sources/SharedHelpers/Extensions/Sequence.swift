//
//  Sequence.swift
//  Collection
//
//  Created by Dave Coleman on 25/9/2024.
//

import Foundation

extension Sequence where Element: Identifiable {

  public func mostRecent<T: Comparable>(
    by dateKeyPath: KeyPath<Element, T>
  ) -> Element? {

    self.max(by: { $0[keyPath: dateKeyPath] < $1[keyPath: dateKeyPath] })

  }
}
extension Sequence where Element: Hashable {
  /// Creates a dictionary from the elements in the sequence with the same default value.
  public func dictionaryWithDefault<T>(_ defaultValue: T) -> [Element: T] {
    Dictionary(uniqueKeysWithValues: self.map { ($0, defaultValue) })
  }
}

extension Sequence {
  public func summarise(
    key: PartialKeyPath<Element>,
    //    key: KeyPath<Element, T>,
    delimiter: Character? = ","
  ) -> String {
    return self.map { String(describing: $0[keyPath: key]) }
      .enumerated()
      .reduce(into: "") { (result, element) in
        let (index, value) = element
        if index > 0 {
          if let delimiter {
            result += "\(delimiter) "
          }
        }
        result += value
      }
  }

  /// Non-native key path based sorting
  public func sorted<T: Comparable>(
    byKeyPath keyPath: KeyPath<Element, T>,
    using comparator: (T, T) -> Bool = (<)
  ) -> [Element] {
    sorted { a, b in
      comparator(a[keyPath: keyPath], b[keyPath: keyPath])
    }
  }

  public func groupedDictionary<K: Hashable>(
    by keyPath: KeyPath<Element, K>
  ) -> [K: [Element]] {
    Dictionary(grouping: self, by: { $0[keyPath: keyPath] })
  }

  /// Safely creates a dictionary from this sequence
  public func toDictionary<Key: Hashable, Value>(
    key: KeyPath<Element, Key>,
    value: KeyPath<Element, Value>,
    uniquingKeysWith strategy: @escaping (Value, Value) -> Value
  ) -> [Key: Value] {
    var result = [Key: Value]()
    for element in self {
      let key = element[keyPath: key]
      let value = element[keyPath: value]

      if let existing = result[key] {
        result[key] = strategy(existing, value)
      } else {
        result[key] = value
      }
    }
    return result
  }

  /// Convenience overload that keeps the first value
  public func toDictionary<Key: Hashable, Value>(
    key: KeyPath<Element, Key>,
    value: KeyPath<Element, Value>
  ) -> [Key: Value] {
    toDictionary(key: key, value: value) { first, _ in first }
  }

  /// Convenience for when the element itself is the value
  public func toDictionary<Key: Hashable>(
    key: KeyPath<Element, Key>
  ) -> [Key: Element] {
    toDictionary(key: key, value: \.self)
  }
}
