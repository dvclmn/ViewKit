//
//  SubString.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 26/9/2025.
//

import Foundation

public enum OmissionStrategy {
  case omitAllEmpty
  case omitLastLineIfEmpty
  case doNotOmit

  public var shouldOmit: Bool {
    switch self {
      case .omitAllEmpty: true
      case .omitLastLineIfEmpty: false
      case .doNotOmit: false
    }
  }
}

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

  public func substringLines(
    separator: String = "\n",
    omissionStrategy: OmissionStrategy = .doNotOmit,
  ) -> [Substring] {
    let subsequence: [Substring] = self.split(
      separator: separator,
      maxSplits: Int.max,
      omittingEmptySubsequences: omissionStrategy.shouldOmit
    )
    switch omissionStrategy {
      case .omitAllEmpty, .doNotOmit:
        return subsequence

      case .omitLastLineIfEmpty:
        guard let lastLine = subsequence.last else { return subsequence }
        let result = lastLine.isEmpty ? Array(subsequence.dropLast()) : subsequence
        return result
    }
  }

  /// Returns an empty string if `self` is empty
  public var firstLine: String {
    let first = split(separator: "\n").first ?? ""
    return String(first)
  }

  /// Appends a newline character (`\n`) to the end of the string if it does
  /// not already end with one. Otherwise returns the original string unchanged.
  public var addingNewLine: String {
    guard self.last != "\n" else {
      return self
    }
    return self + "\n"
  }

  public func components(separatedBy separator: Character) -> [String] {
    return self.split(separator: separator).map(String.init)
  }

  public func lines(omissionStrategy: OmissionStrategy = .doNotOmit) -> [String] {
    let lines: [String] = self.substringLines(
      omissionStrategy: omissionStrategy
    ).map { substring in
      String(substring)
    }
    return lines
  }

  public var longestLineLength: Int {
    let longestLine = substringLines(omissionStrategy: .doNotOmit).map { $0.count }.max() ?? 1
    return longestLine
  }

  public func linesIndented(
    level: Int = 1,
    using indentString: String = "\t"
  ) -> String {
    let indent = String(repeating: indentString, count: level)
    let indentedLines = self.substringLines().map { indent + $0 }
    return indentedLines.joined("\n")
  }

  public func linesJoined(
    _ separator: String = "\t"
  ) -> String {
    self.substringLines().map { String($0) }.joined(separator)
  }

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
