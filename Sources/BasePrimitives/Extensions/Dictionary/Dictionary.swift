//
//  Dictionary.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 30/6/2025.
//

import Foundation

extension Dictionary where Key: CustomStringConvertible, Value: CustomStringConvertible {
  public func displayString<T: Comparable>(
    sortedBy keyPath: KeyPath<Element, T>,
    keyValueSeparator: String = ": ",
    pairSeparator: String = ", "
  ) -> String {
    sorted(by: keyPath)
      .map { $0.key.description + keyValueSeparator + $0.value.description }
      .joined(separator: pairSeparator)
  }

  public func prettyPrinted(
    //  public func prettyPrinted<T: Comparable>(
    aligned: Bool = true,
    //    sortedBy keyPath: KeyPath<Element, T>,
  ) -> String {
    guard !isEmpty else { return "[:]" }

    let pairs = map {
      (key: "\"\($0)\":", value: "\"\($1)\"")
    }
    .sorted { $0.key < $1.key }
    //    .sorted(by: keyPath)

    let lines: [String]

    if aligned {
      let maxKeyLength = pairs.map(\.key.count).max() ?? 0
      lines = pairs.map { key, value in
        let padding = String(repeating: " ", count: maxKeyLength - key.count + 1)
        return "    \(key)\(padding)\(value)"
      }
    } else {
      lines = pairs.map { key, value in
        "    \(key) \(value)"
      }
    }

    return "[\n\(lines.joined(separator: "\n"))\n]"
  }

  //  func prettyPrint(aligned: Bool = true) {
  //    print(prettyPrinted(aligned: aligned))
  //  }

  //extension Dictionary: StringRenderable where Key: StringRenderable, Value: StringRenderable {

  //        (
  //          "Elements",
  //          store.userData().elementDefaults
  //            .sorted(by: \.key.id)
  //            .map { $0.key.rawValue + ": " + $0.value.toString }
  //            .joined(separator: ", ")
  //        ),
  //        ("Element Defaults", store.userData.elementDefaults.count.toString),
  //  public var toString: String { map(\.toString).joined(separator: ", ") }
  //}

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
    self.flatMap(\.value).sorted(by: keyPath)
  }
}

extension Dictionary {

  /// Returns this dictionary's values sorted by the given key path.
  ///
  /// - Parameter keyPath: A key path from `Value` to a `Comparable` property used for sorting.
  /// - Returns: An array of values sorted ascending by the value at `keyPath`.
  /// - Complexity: O(n log n), where n is the number of key–value pairs in the dictionary.
  ///
  /// ### Example
  /// ```swift
  /// let dict = ["b": User(age: 40), "a": User(age: 20)]
  /// let values = dict.sortedValues(by: \User.age)
  /// // values are [User(age: 20), User(age: 40)]
  /// ```
  public func sortedValues<T: Comparable>(
    by keyPath: KeyPath<Value, T>
  ) -> [Value] {
    self.map(\.value).sorted(by: keyPath)
  }

  /// Returns this dictionary's keys sorted by the given key path.
  ///
  /// - Parameter keyPath: A key path from `Key` to a `Comparable` property used for sorting.
  /// - Returns: An array of keys sorted ascending by the value at `keyPath`.
  /// - Complexity: O(n log n), where n is the number of key–value pairs in the dictionary.
  ///
  /// ### Example
  /// ```swift
  /// struct Tag { let name: String }
  /// let dict: [Tag: Int] = [Tag(name: "b"): 2, Tag(name: "a"): 1]
  /// let keys = dict.sortedKeys(by: \Tag.name)
  /// // keys are [Tag(name: "a"), Tag(name: "b")]
  /// ```
  public func sortedKeys<T: Comparable>(
    by keyPath: KeyPath<Key, T>
  ) -> [Key] {
    self.map(\.key).sorted(by: keyPath)
  }

  /// Returns the dictionary's key–value pairs sorted by a property of the value.
  ///
  /// Use this to obtain a stable array of pairs when you need ordering for iteration
  /// (for example, with SwiftUI's `ForEach`). The sort compares the value at the
  /// provided key path in ascending order.
  ///
  /// - Parameter keyPath: A key path from `Value` to a `Comparable` used for sorting.
  /// - Returns: An array of `(key: Key, value: Value)` tuples sorted by `Value`'s property.
  /// - Complexity: O(n log n), where n is the number of key–value pairs.
  ///
  /// ### Example
  /// ```swift
  /// let swatches: [String: Color] = ["Purple": .purple, "Mint": .mint]
  /// // Sort by a hypothetical comparable attribute on Color
  /// let pairs = swatches.sortedByValue(\.description)
  /// // pairs are sorted by the Color's description ascending
  /// ```
  public func sortedByValue<T: Comparable>(
    _ keyPath: KeyPath<Value, T>
  ) -> [(Key, Value)] {
    self.sorted { $0.value[keyPath: keyPath] < $1.value[keyPath: keyPath] }
  }

  /// Returns the dictionary's key–value pairs sorted by a property of the key.
  ///
  /// This is useful when the key is a complex type and you want ordering by one of
  /// its comparable properties.
  ///
  /// - Parameter keyPath: A key path from `Key` to a `Comparable` used for sorting.
  /// - Returns: An array of `(key: Key, value: Value)` tuples sorted by `Key`'s property.
  /// - Complexity: O(n log n), where n is the number of key–value pairs.
  ///
  /// ### Example
  /// ```swift
  /// struct Tag { let name: String }
  /// let dict: [Tag: Int] = [Tag(name: "b"): 2, Tag(name: "a"): 1]
  /// let pairs = dict.sortedByKey(\Tag.name)
  /// // pairs are sorted by the tag's name ascending
  /// ```
  public func sortedByKey<T: Comparable>(
    _ keyPath: KeyPath<Key, T>
  ) -> [(Key, Value)] {
    self.sorted { $0.key[keyPath: keyPath] < $1.key[keyPath: keyPath] }
  }
}

extension Dictionary {
  public subscript(optionalKey key: Key?) -> Value? {
    guard let key else { return nil }
    return self[key]
  }
}
