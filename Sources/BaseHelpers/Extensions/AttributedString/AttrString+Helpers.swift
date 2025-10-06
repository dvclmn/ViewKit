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
    from matches: [RegexMatch],
  ) -> [AttributedRange] {
    return matches.compactMap { match in
      self.range(of: match.output)
    }
  }

  public func getRanges(
    matching pattern: Regex<Substring>
  ) -> [AttributedRange] {
    let matches = findMatches(for: pattern)
    return getRanges(from: matches)
  }

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
    matches.forEach { match in
      if let range = self.range(of: match.output) {
        transform(&self[range])
      }
    }
  }

  public mutating func editAttributes(
    matching pattern: Regex<Substring>,
    transform: (inout AttributedSubstring) -> Void
  ) {
    let matches = findMatches(for: pattern)
    self.editAttributes(for: matches, transform: transform)
  }

//  public func styled(
//    matches: [RegexMatch],
//    attributes: AttributeContainer
//  ) -> Self {
//    var new = self
//    for match in matches {
//      if let range: Range<AttributedString.Index> = self.range(of: match.output) {
//        new[range].mergeAttributes(attributes)
//      }
//    }
//    return new
//  }

//  @discardableResult
//  public mutating func findRangesAndApplyAttributes(
//    matching pattern: Regex<Substring>,
//    attributes: AttributeContainer
//  ) -> [AttributedRange] {
//    let matches = findMatches(for: pattern)
//    return findRangesAndApplyAttributes(for: matches, attributes: attributes)
//  }

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
