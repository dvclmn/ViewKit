//
//  Regex.swift
//  Collection
//
//  Created by Dave Coleman on 14/2/2025.
//

import Foundation
import RegexBuilder

// MARK: - Typealiases

/// A `Regex` with captures created from a regex literal or the
///   ``init(_:as:)`` initializer.
///
/// The output type is a tuple of substrings.
///
/// Important: The *first* component of the tuple is the full portion of the string
/// that was matched, with the remaining components holding the captures.
///
/// That's why each of these has one more than it's name implies,
/// as the first handles the whole match.

public typealias AttributedRange = Range<AttributedString.Index>

extension Regex.Match {

  public func toNSRange(in text: String) -> NSRange? { range.toNSRange(in: text) }

  /// Provides the range for a specific capture group, relative to the original searched text (*not* to the match output `Substring`)
  public func range(for keypath: KeyPath<Output, Substring>) -> Range<String.Index>? {
    let substring = self.output[keyPath: keypath]
    let range = substring.indexRange
    return range
  }

  /// Provides the range for a specific capture group
  public func nsRange(
    for keypath: KeyPath<Output, Substring>,
    in originalText: String
  ) -> NSRange? {
    range(for: keypath)?.toNSRange(in: originalText)

  }
}
