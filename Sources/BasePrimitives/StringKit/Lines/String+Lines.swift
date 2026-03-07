//
//  SubString.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 26/9/2025.
//

import Foundation

extension Array where Element == String {
  public func preprendToFirstLine(_ element: Element) -> [Element] {
    var result: [Element] = self
    result[0] = element + "\(result[0])"
    return result
  }

  public func appendToLastLine(_ element: Element) -> [Element] {
    var result: [Element] = self
    result[result.endIndex - 1] = "\(result[result.endIndex - 1])\(element)"
    return result
  }
}

extension String {

  public var isLastLineEmpty: Bool {
    lines().last?.isEmpty == true
  }

  public func lines(omissionStrategy: OmissionStrategy = .doNotOmit) -> [Substring] {
    omissionStrategy.split(self, whereSeparator: \.isNewline)
  }

  public func characterLines(omissionStrategy: OmissionStrategy = .doNotOmit) -> [[Substring.Element]] {
    lines(omissionStrategy: omissionStrategy).map(Array.init)
  }

  /// Purely a convenience for converting ``lines(omissionStrategy:)``
  /// from `[Substring]` to `[String]`
  public func stringLines(omissionStrategy: OmissionStrategy = .doNotOmit) -> [String] {
    lines(omissionStrategy: omissionStrategy).map(String.init)
  }

  public func components(
    separatedBy separator: Character,
    omissionStrategy: OmissionStrategy = .doNotOmit
  ) -> [String] {
    omissionStrategy
      .split(self, separator: separator)
      .map(String.init)
  }

  //  public func lines(omissionStrategy: OmissionStrategy = .doNotOmit) -> [Substring] {
  //
  //    let subsequence = split(
  //      maxSplits: Int.max,
  //      omittingEmptySubsequences: omissionStrategy.shouldOmit,
  //      whereSeparator: \.isNewline
  //    )
  //
  //    switch omissionStrategy {
  //      case .omitAllEmpty, .doNotOmit:
  //        return subsequence
  //
  //      case .omitLastLineIfEmpty:
  //        guard let lastLine = subsequence.last else { return subsequence }
  //        let result = lastLine.isEmpty ? Array(subsequence.dropLast()) : subsequence
  //        return result
  //    }
  //  }

  @available(*, deprecated, renamed: "lines(omissionStrategy:)")
  public func substringLines(omissionStrategy: OmissionStrategy = .doNotOmit) -> [Substring] {
    lines(omissionStrategy: omissionStrategy)
  }

  /// Returns an empty string if `self` is empty
  public var firstLine: String {
    let first = split(separator: "\n").first ?? ""
    return String(first)
  }

  //  public var isNewLine: Bool {
  //    contains(where: \.isNewline)
  //  }

  /// Appends a newline character (`\n`) to the end of the string if it does
  /// not already end with one. Otherwise returns the original string unchanged.
  public var addingNewLine: String {
    guard let last, !last.isNewline else {
      return self
    }
    return self + "\n"
  }

  public var longestLineLength: Int {
    lines(omissionStrategy: .doNotOmit)
      .map { $0.count }.max() ?? 1
  }

  public func linesIndented(
    level: Int = 1,
    using indentString: String = "\t"
  ) -> String {
    let indent = String(repeating: indentString, count: level)
    let indentedLines = lines().map { indent + $0 }
    return indentedLines.joined("\n")
  }

  //  public func linesJoined(
  //    _ separator: String = "\t"
  //  ) -> String {
  //    lines().map { String($0) }.joined(separator)
  //  }

  public func insertingLineBreak(every characters: Int) -> String {
    guard characters > 0 else { return self }

    var lines: [String] = []
    var currentIndex = startIndex

    while currentIndex < endIndex {
      let remainingDistance = distance(from: currentIndex, to: endIndex)
      let chunkSize = min(characters, remainingDistance)

      let nextIndex = index(currentIndex, offsetBy: chunkSize)
      let line = String(self[currentIndex..<nextIndex])
      lines.append(line)

      currentIndex = nextIndex
    }

    return lines.joined("\n")
  }

}
