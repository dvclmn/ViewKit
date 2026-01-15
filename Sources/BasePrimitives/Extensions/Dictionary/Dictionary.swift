//
//  Dictionary.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 30/6/2025.
//

import Foundation

extension Dictionary where Key: CustomStringConvertible, Value: CustomStringConvertible {

//  public func displayString() -> String {
//    guard !self.isEmpty else { return "nil" }
//
//    let formattedPairs = self.map { key, value in
//      "  | \"\(key)\": \"\(value)\""
//    }
//
//    return "\n" + formattedPairs.joined(separator: "\n")
//  }
}

extension Dictionary {

  /// Non-native key path based sorting for Dictionary
  public func sorted<T: Comparable>(
    byKeyPath keyPath: KeyPath<Element, T>,
    using comparator: (T, T) -> Bool = (<)
  ) -> [Element] {
    sorted { a, b in
      comparator(a[keyPath: keyPath], b[keyPath: keyPath])
    }
  }

  /// Allows use of a `KeyPath` for grouping, like
  /// ```
  /// var groupedDictionary: [String: [Swatch]] {
  ///   Dictionary(
  ///     grouping: Swatch.allCases,
  ///     by: keyPath
  ///   )
  /// }
  /// ```
  public init<S: Sequence>(
    grouping values: S,
    by keyPath: KeyPath<S.Element, Key>
  ) where Value == [S.Element] {
//    print("Performed a grouping operation for \(Array(values).count) values, at \(Date.debug)")
    self.init(grouping: values, by: { $0[keyPath: keyPath] })
  }

}

extension Dictionary where Value: Sequence {
  /// Flattens all values and sorts the resulting elements by the given key path.
  public func sortedGrouped<T: Comparable>(
    by keyPath: KeyPath<Value.Element, T>
  ) -> [Value.Element] {
    self.flatMap(\.value).sorted(byKeyPath: keyPath)
  }
}


extension Dictionary {
  public subscript(optionalKey key: Key?) -> Value? {
    guard let key else { return nil }
    return self[key]
  }
}
