//
//  Sequence.swift
//  Collection
//
//  Created by Dave Coleman on 25/9/2024.
//

import Foundation

/// 🔔 Remember: Types like Array, Set and Dictionary conform to Sequence
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

/// Example usage:
/// `let uniqueSyntaxes = runs.map(\.syntax).uniquedPreservingOrder()`
extension Sequence where Element: Equatable {
  public func uniquedPreservingOrder() -> [Element] {
    var seen: [Element] = []
    for element in self where !seen.contains(element) {
      seen.append(element)
    }
    return seen
  }
}

extension Sequence {

  public func summarise<T: Comparable>(
    key: PartialKeyPath<Element>,
    sortedBy keyPath: KeyPath<Element, T>,
    delimiter: Character? = ","
  ) -> String {
    return
      self
      .sorted(by: keyPath)
      .map { String(describing: $0[keyPath: key]) }
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
    by keyPath: KeyPath<Element, T>,
    using comparator: (T, T) -> Bool = (<)
  ) -> [Element] {
    sorted { a, b in
      comparator(a[keyPath: keyPath], b[keyPath: keyPath])
    }
  }

}
