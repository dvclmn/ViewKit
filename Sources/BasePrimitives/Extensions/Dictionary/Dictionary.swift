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
  public subscript(optionalKey key: Key?) -> Value? {
    guard let key else { return nil }
    return self[key]
  }
}
