//
//  AttributedRange.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 3/10/2025.
//

import Foundation

extension AttributedString {

  public func findMatches(for pattern: Regex<Substring>) -> [RegexMatch] {
    let string = String(self.characters)
    let matches = string.matches(of: pattern)
    return matches
  }

  public func getRange(for matches: [RegexMatch]) -> AttributedRange? {
    return matches.lazy
      .compactMap { self.range(of: $0.output) }
      .first
  }

  public func getRange(matching pattern: Regex<Substring>) -> AttributedRange? {
    let matches = findMatches(for: pattern)
    return getRange(for: matches)
  }

  public func getAllRanges(
    for matches: [RegexMatch]
  ) -> [AttributedRange] {
    return matches.compactMap { match in
      self.range(of: match.output)
    }
  }

  public func getAllRanges(matching pattern: Regex<Substring>) -> [AttributedRange] {
    let matches = findMatches(for: pattern)
    return getAllRanges(for: matches)
  }

  @discardableResult
  public mutating func findRangesAndApplyAttributes(
    for matches: [RegexMatch],
    attributes: AttributeContainer
  ) -> [AttributedRange] {
    var ranges: [AttributedRange] = []
    for match in matches {
      if let range = self.range(of: match.output) {
        self[range].setAttributes(attributes)
        ranges.append(range)
      }
    }
    return ranges
  }

  public func styled(
    matches: [RegexMatch],
    attributes: AttributeContainer
  ) -> Self {
    //    var ranges: [AttributedRange] = []
    var new = self
    for match in matches {
      if let range = self.range(of: match.output) {
        new[range].mergeAttributes(attributes)
//        new[range].setAttributes(attributes)
        //        ranges.append(range)
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
