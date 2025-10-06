//
//  AttributedRange.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 3/10/2025.
//

import Foundation

/// What are ranges?
/// Pattern -> Matches -> Ranges -> Then can work with that `AttributedSubstring`

extension AttributedString {

  /// If no value is provided to `matches`, this will fall back by
  /// first converting `self` to `String`, then searching for
  /// matches in that. String conversion may incur performance cost
  public func getRanges(
    using matches: [RegexMatch]? = nil,
    matching pattern: Regex<Substring>
  ) -> [AttributedRange] {
    let patternMatches = matches ?? findMatches(for: pattern)
    return patternMatches.compactMap { match in
      self.range(of: match.output)
    }
  }

  //  private func matchesWithFallback(
  //    using matches: [RegexMatch]? = nil,
  //    matching pattern: Regex<Substring>
  //  ) -> [RegexMatch] {
  //    matches ?? findMatches(for: pattern)
  //  }

  /// Use this method if an existing String representation
  /// for `self` does not already exist. This will first
  /// convert to `String`, then find matches. String
  /// conversion may incur performance cost.
  private func findMatches(for pattern: Regex<Substring>) -> [RegexMatch] {
    let string = String(self.characters)
    let matches = string.matches(of: pattern)
    return matches
  }

  public mutating func editAttributes(
    for matches: [RegexMatch],
    transform: (inout AttributedSubstring) -> Void
  ) {
    for match in matches {
      processMatch(match, transform: transform)
    }
  }

  public mutating func editAttributes(
    matching pattern: Regex<Substring>,
    transform: (inout AttributedSubstring) -> Void
  ) {

    let matches = findMatches(for: pattern)
    //    let matches = matchesWithFallback(using: matches, matching: pattern)
    for match in matches {
      processMatch(match, transform: transform)
    }
  }

  private mutating func processMatch(
    _ match: RegexMatch,
    transform: (inout AttributedSubstring) -> Void
  ) {
    if let range = self.range(of: match.output) {
      transform(&self[range])
    }
  }

  //  public func getAllRanges(
  //    for matches: [RegexMatch]
  //  ) -> [AttributedRange] {
  //    return matches.compactMap { match in
  //      self.range(of: match.output)
  //    }
  //  }

  //  public func getAllRanges(matching pattern: Regex<Substring>) -> [AttributedRange] {
  //    let matches = findMatches(for: pattern)
  //    return getAllRanges(for: matches)
  //  }

  //  @discardableResult
  //  public mutating func findRangesAndApplyAttributes(
  //    for matches: [RegexMatch],
  //    attributes: AttributeContainer
  //  ) -> [AttributedRange] {
  //    var ranges: [AttributedRange] = []
  //    for match in matches {
  //      if let range = self.range(of: match.output) {
  //        self[range].setAttributes(attributes)
  //        ranges.append(range)
  //      }
  //    }
  //    return ranges
  //  }

  public func styled(
    matches: [RegexMatch],
    attributes: AttributeContainer
  ) -> Self {
    //    var ranges: [AttributedRange] = []
    var new = self
    for match in matches {
      if let range: Range<AttributedString.Index> = self.range(of: match.output) {
        new[range].mergeAttributes(attributes)
      }
    }

    return new
  }

  @discardableResult
  public mutating func findRangesAndApplyAttributes(
    matching pattern: Regex<Substring>,
    attributes: AttributeContainer
  ) -> [AttributedRange] {
    let matches = findMatches(for: pattern)
    return findRangesAndApplyAttributes(for: matches, attributes: attributes)
  }

  #warning("Find way to write similar code for Single, Double, Triple captures, without redundancy etc")
  //  public func getRange(for pattern: TripleCapture) -> TripleCaptureRange? {
  //
  //    let string = String(self.characters)
  //
  //    let matches = string.matches(of: pattern)
  //
  //    for match in matches {
  //      guard let range01 = self.range(of: match.output.1),
  //        let range02 = self.range(of: match.output.2),
  //        let range03 = self.range(of: match.output.3)
  //      else {
  //
  //        break
  //      }
  //
  //      return (range01, range02, range03)
  //    }
  //    return nil
  //  }

}
