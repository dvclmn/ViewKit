//
//  Dict+Array.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 12/11/2025.
//

import Foundation

extension Array {
  /// ```
  /// let dicts = [
  ///   ["a": 1, "b": 2],
  ///   ["b": 3, "c": 4]
  /// ]
  ///
  /// let keepNew = dicts.reduceDictionaries(keeping: .new)     // ["a": 1, "b": 3, "c": 4]
  /// let keepCurrent = dicts.reduceDictionaries(keeping: .current) // ["a": 1, "b": 2, "c": 4]
  /// ```
  public func merged<Key: Hashable, Value>(
    keeping strategy: MergeStrategy<Key, Value> = .first
  ) -> [Key: Value] where Element == [Key: Value] {
    reduce(into: [:]) { partial, dict in
      switch strategy {
        case .first:
          partial.merge(dict) { current, _ in current }

        case .last:
          partial.merge(dict) { _, new in new }

        case .custom(let combine):
          partial.merge(dict, uniquingKeysWith: combine)
      }
    }
  }
}
