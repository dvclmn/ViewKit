//
//  String.swift
//  TextCore
//
//  Created by Dave Coleman on 9/10/2024.
//

import SwiftUI

extension String {

  /// Pads the string with spaces on the right to at least the given width.
  public func padded(
    to width: Int,
    using padString: String = " "
  ) -> String {
    if count >= width { return self }
    return self + String(repeating: padString, count: width - count)
  }

  public enum QuotesType: String {
    case single = "'"
    case double = "\""
  }

  public var toURL: URL? {
    return URL(string: self)
  }
  
  public func combining(
    with other: String,
    separator: String = ", "
  ) -> String {
    self + separator + other
  }

  public var withQuotes: String {
    self.withQuotes(.double)
  }

  public func findMatches(for pattern: Regex<Substring>) -> [RegexMatch] {
    let matches = self.matches(of: pattern)
    return matches
  }

  //  public func getRange(
  //    for attrString: AttributedString,
  //    matching pattern: Regex<Substring>
  //  ) -> AttributedRange? {
  //    let matches = findMatches(for: pattern)
  //    return attrString.getRange(for: matches)
  //  }

  //  public func getAttributedRanges
  //  public func getAllRanges(
  //    for attrString: AttributedString,
  //    matching pattern: Regex<Substring>
  //  ) -> [AttributedRange] {
  //    let matches = findMatches(for: pattern)
  //    return attrString.getAllRanges(for: matches)
  //  }

  //  @discardableResult
  //  public func findRangesAndApplyAttributes(
  //    to attrString: inout AttributedString,
  //    matching pattern: Regex<Substring>,
  //    attributes: AttributeContainer
  //  ) -> [AttributedRange] {
  //    let matches = findMatches(for: pattern)
  //    return attrString.findRangesAndApplyAttributes(for: matches, attributes: attributes)
  //  }
  //
  //  public func getAttributed(
  //    text: AttributedString,
  //    //    to attrString: inout AttributedString,
  //    matching pattern: Regex<Substring>,
  //    attributes: AttributeContainer
  //  ) -> AttributedString {
  //    let matches = findMatches(for: pattern)
  //    return text.styled(matches: matches, attributes: attributes)
  //    //    return attrString.findRangesAndApplyAttributes(for: matches, attributes: attributes)
  //  }

  public func withQuotes(_ type: QuotesType = .double) -> String {
    return "\(type.rawValue)\(self)\(type.rawValue)"
  }

  public var toAttributed: AttributedString {
    return AttributedString(self)
  }

  public var toMarkdownCompatible: LocalizedStringKey {
    LocalizedStringKey(self)
  }

  public var firstLine: String {
    let firstSubstring = self.split(separator: "\n").first ?? ""
    return String(firstSubstring)
  }

  /// Adds a new line to the end of the current String, unless already present
  public var addingNewLine: String {
    guard self.last != "\n" else {
      return self
    }
    return self + "\n"
  }

  public func components(separatedBy separator: Character) -> [String] {
    return self.split(separator: separator).map(String.init)
  }

  public var wordCount: Int {
    let words = self.split { !$0.isLetter }
    return words.count
  }

  public func nsRange(from range: Range<String.Index>) -> NSRange {
    return NSRange(range, in: self)
  }

  public func range(from nsRange: NSRange) -> Range<String.Index>? {
    return Range(nsRange, in: self)
  }

  public func substring(with nsRange: NSRange) -> Substring? {
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

public enum TruncationStyle {
  case start  // "...end"
  case middle  // "begin...end"
  case end  // "begin..."
}

extension String {
  /// Truncates a string to a maximum length using the specified truncation style.
  /// The ellipsis ("...") does not count toward the maxLength.
  ///
  /// Examples:
  /// - "Hello World".truncate(to: 8, style: .middle) → "Hell...orld"
  /// - "Hello World".truncate(to: 8, style: .end) → "Hello..."
  /// - "Hello World".truncate(to: 8, style: .start) → "...World"
  /// - "Short".truncate(to: 10) → "Short" (unchanged)
  /// - "".truncate(to: 10) → "(Empty)"
  ///
  /// - Parameters:
  ///   - maxLength: Maximum number of content characters to show (ellipsis not counted, minimum 2)
  ///   - style: The truncation style (.start, .middle, or .end)
  ///   - emptyPlaceholder: Text to show when the string is empty
  /// - Returns: Truncated string with ellipsis, or original string if shorter than maxLength
  public func truncate(
    to maxLength: Int = 20,
    style: TruncationStyle = .middle,
    emptyPlaceholder: String = "(Empty)"
  ) -> String {

    // Handle empty string
    guard !self.isEmpty else { return emptyPlaceholder }

    // Ensure minimum length for meaningful truncation
    let minLength = 2
    let effectiveMaxLength = max(minLength, maxLength)

    // If string is short enough, return as-is
    guard self.count > effectiveMaxLength else { return self }

    let ellipsis = "..."

    switch style {
      case .start:
        let suffix = String(self.suffix(effectiveMaxLength))
        return "\(ellipsis)\(suffix)"

      case .middle:
        let prefixLength = effectiveMaxLength / 2
        let suffixLength = effectiveMaxLength - prefixLength
        let prefix = String(self.prefix(prefixLength))
        let suffix = String(self.suffix(suffixLength))
        return "\(prefix)\(ellipsis)\(suffix)"

      case .end:
        let prefix = String(self.prefix(effectiveMaxLength))
        return "\(prefix)\(ellipsis)"
    }
  }

  /// Wraps text in decorative dividers for display purposes
  public func wrappedInDividers() -> String {
    return "\n---\n\(self)\n---\n"
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
  //extension Optional where Wrapped == String {
  public var toDescribing: String {
    return String(describing: self)
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
