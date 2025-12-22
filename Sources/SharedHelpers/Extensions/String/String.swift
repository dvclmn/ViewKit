//
//  String.swift
//  TextCore
//
//  Created by Dave Coleman on 9/10/2024.
//

import SwiftUI

// Source - https://stackoverflow.com/a
// Posted by Leo Dabus, modified by community. See post 'Timeline' for change history
// Retrieved 2025-11-21, License - CC BY-SA 4.0
extension StringProtocol {
  public subscript(offset offset: Int) -> Element {
    self[index(startIndex, offsetBy: offset)]
  }

  public subscript(range range: Range<Int>) -> SubSequence {
    prefix(range.lowerBound + range.count).suffix(range.count)
  }
  public subscript(range range: ClosedRange<Int>) -> SubSequence {
    prefix(range.lowerBound + range.count).suffix(range.count)
  }
  public subscript(range range: PartialRangeThrough<Int>) -> SubSequence {
    prefix(range.upperBound.advanced(by: 1))
  }
  public subscript(range range: PartialRangeUpTo<Int>) -> SubSequence {
    prefix(range.upperBound)
  }

  subscript(_ range: PartialRangeFrom<Int>) -> SubSequence {
    suffix(Swift.max(0, count - range.lowerBound))
  }
}

extension String {

  /// Pads the string with spaces on the right to at least the given width.
  public func padded(
    to width: Int,
    using padString: String = " "
  ) -> String {
    if count >= width { return self }
    return self + String(repeating: padString, count: width - count)
  }

  public func combining(
    with other: String,
    separator: String = ", "
  ) -> String {
    self + separator + other
  }

//  public func findMatches(for pattern: Regex<Substring>) -> [RegexMatch] {
//    let matches = self.matches(of: pattern)
//    return matches
//  }

  public var wordCount: Int {
    let words = self.split { !$0.isLetter }
    return words.count
  }

  public func nsRange(from range: Range<String.Index>) -> NSRange? {
    guard range.lowerBound >= startIndex, range.upperBound <= endIndex else {
      return nil
    }
    return NSRange(range, in: self)
  }

  public func range(from nsRange: NSRange) -> Range<String.Index>? {
    return Range(nsRange, in: self)
  }

  public func substring(in nsRange: NSRange) -> Substring? {
    guard let range = self.range(from: nsRange) else { return nil }
    return self[range]
  }

  /// ```
  /// let test1 =   "a[b]c".slice(from: "[", to: "]") // "b"
  /// let test2 =     "abc".slice(from: "[", to: "]") // nil
  /// let test3 =   "a]b[c".slice(from: "[", to: "]") // nil
  /// let test4 = "[a[b]c]".slice(from: "[", to: "]") // "a[b"
  /// ```
  public func slice(from: String, to: String) -> String? {
    guard let rangeFrom = range(of: from)?.upperBound else { return nil }
    guard let rangeTo = self[rangeFrom...].range(of: to)?.lowerBound else { return nil }
    return String(self[rangeFrom..<rangeTo])
  }
}

extension Array where Element == String {
  public func joined(_ separator: String = "") -> String {
    self.joined(separator: separator)
  }
  public func joinedLines() -> String {
    self.joined(separator: "\n")
  }
}

extension String {

  public enum QuotesType: String {
    case single = "'"
    case double = "\""
  }

  public var withQuotes: String {
    self.withQuotes(.double)
  }

  public func withQuotes(_ type: QuotesType = .double) -> String {
    return "\(type.rawValue)\(self)\(type.rawValue)"
  }

}

extension UUID {
  public func truncated(
    to maxLength: Int = 8,
    style: TruncationStyle = .middle,
  ) -> String {
    self.uuidString.truncate(to: maxLength, style: style)
  }
}

//extension Range where Bound == String.Index {
//  public func toNSRange(in string: String) -> NSRange? {
//    return string.nsRange(from: self)
//  }
//}
