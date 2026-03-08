//
//  AttributedString.swift
//  TextCore
//
//  Created by Dave Coleman on 31/8/2024.
//

import SwiftUI

extension AttributedString {
//  public var toString: String { String(self.characters) }

  public func index(at offset: Int) -> AttributedString.Index? {
    guard offset >= 0 && offset <= characters.count else {
      return nil
    }
    return index(startIndex, offsetByCharacters: offset)
  }
  
  public func monospaced(_ font: Font? = nil) -> AttributedString {
    self.transformingAttributes(\.font) { attr in
      attr.value = font?.monospaced() ?? Font.body.monospaced()
    }
  }

  ///
  /// ```
  /// var output = attrString
  ///
  /// let numberByNumberPattern: Regex.TripleCapture = /([\d\.]+)(x)([\d\.]+)/
  ///
  /// if let ranges = getRange(for: numberByNumberPattern, in: output) {
  ///   output[ranges.0].setAttributes(style(for: part, subPart: .number))
  ///   output[ranges.1].setAttributes(style(for: part, subPart: .operator))
  ///   output[ranges.2].setAttributes(style(for: part, subPart: .number))
  /// }
  ///
  /// return output
  /// ```

  public mutating func quickHighlight() {
    let highlightContainer: AttributeContainer = .colours(.black, on: .green)
    self.setAttributes(highlightContainer)
  }

  public func lines(omissionStrategy: OmissionStrategy = .doNotOmit) -> [Substring] {
    toString.lines(omissionStrategy: omissionStrategy)
  }

  public func stringLines(omissionStrategy: OmissionStrategy = .doNotOmit) -> [String] {
    toString.stringLines(omissionStrategy: omissionStrategy)
  }

  public mutating func append(
    _ string: String,
    addsLineBreak: Bool
  ) {
    self.characters.append(contentsOf: addsLineBreak ? "\(string)\n" : "\(string)")
  }

  public mutating func append(
    _ character: Character,
    addsLineBreak: Bool
  ) {
    self.characters.append(contentsOf: addsLineBreak ? "\(character)\n" : "\(character)")
  }

  public mutating func addLineBreak() {
    self.characters.append("\n")
  }

}

extension Array where Element == AttributedString {
  public func joined(_ separator: String = "") -> AttributedString {
    guard !isEmpty else { return AttributedString() }

    /// Pre-create separator once to avoid repeated initialisation
    let separatorAttr = AttributedString(separator)

    /// Use reduce(into:) for in-place mutation (no copies)
    return dropFirst().reduce(into: self[0]) { result, element in
      result.append(separatorAttr)
      result.append(element)
    }
  }
}

extension AttributedString {
  public func appending(_ string: String) -> AttributedString {
    var copy = self
    copy.append(string.toAttributed)
    return copy
  }
  //  public static func + (lhs: AttributedString, rhs: String) -> AttributedString {
  //    var result = lhs
  //    result.append(AttributedString(rhs))
  //    return result
  //  }
  //
  //  public static func + (lhs: String, rhs: AttributedString) -> AttributedString {
  //    var result = AttributedString(lhs)
  //    result.append(rhs)
  //    return result
  //  }
}

extension String {
  /// Returns an attributed string
  public func appending(_ attributed: AttributedString) -> AttributedString {
    var attr = self.toAttributed
    attr.append(attributed)
    return attr

  }
}

//extension AttributedString {
//
//  /// If no value is provided to `matches`, this will fall back by
//  /// first converting `self` to `String`, then searching for
//  /// matches in that. String conversion may incur performance cost
//  public func getRanges(
//    from matches: [RegexMatch],
//  ) -> [AttributedRange] {
//    return matches.compactMap { match in
//      self.range(of: match.output)
//    }
//  }
//
//  public func getRanges(
//    matching pattern: Regex<Substring>
//  ) -> [AttributedRange] {
//    let matches = findMatches(for: pattern)
//    return getRanges(from: matches)
//  }
//
//  /// Use this method if an existing String representation
//  /// for `self` does not already exist. This will first
//  /// convert to `String`, then find matches. String
//  /// conversion may incur performance cost.
//  private func findMatches(for pattern: Regex<Substring>) -> [RegexMatch] {
//    let string = String(self.characters)
//    let matches = string.matches(of: pattern)
//    return matches
//  }
//
//  public mutating func editAttributes(
//    for matches: [RegexMatch],
//    transform: (inout AttributedSubstring) -> Void
//  ) {
//    matches.forEach { match in
//      if let range = self.range(of: match.output) {
//        transform(&self[range])
//      }
//    }
//  }
//
//  public mutating func editAttributes(
//    matching pattern: Regex<Substring>,
//    transform: (inout AttributedSubstring) -> Void
//  ) {
//    let matches = findMatches(for: pattern)
//    self.editAttributes(for: matches, transform: transform)
//  }
//
//  // TODO: Find way to write similar code for Single, Double, Triple captures, without redundancy etc
//  //  public func getRange(for pattern: TripleCapture) -> TripleCaptureRange? {
//  //
//  //    let string = String(self.characters)
//  //
//  //    let matches = string.matches(of: pattern)
//  //
//  //    for match in matches {
//  //      guard let range01 = self.range(of: match.output.1),
//  //        let range02 = self.range(of: match.output.2),
//  //        let range03 = self.range(of: match.output.3)
//  //      else {
//  //
//  //        break
//  //      }
//  //
//  //      return (range01, range02, range03)
//  //    }
//  //    return nil
//  //  }
//
//}
