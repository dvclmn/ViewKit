//
//  Range+Preview.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 1/1/2026.
//

import Foundation

typealias StringRange = Range<String.Index>

extension Range where Bound == String.Index {
  public func debugPreview(
    in text: String,
    contextLength: Int = 30,
    highlight: (String) -> String = { "░\($0)░" }
  ) -> String {

    let bound = self.lowerBound
    guard !text.isEmpty else { return "" }

    // --- Before ---
    //    let beforeStart =
    //    text.index(
    //      lowerBound,
    //      offsetBy: -contextLength,
    //      limitedBy: text.startIndex
    //    ) ?? text.startIndex
    //
    //    let before = text[beforeStart..<lowerBound]
    //    let beforeLines = String(before).lines().joined("\n| ")
    let hasLeadingTruncation = beforeStart > text.startIndex

    // --- Range ---
    let middle = text[self]

    // --- After ---
    let afterEnd =
      text.index(
        upperBound,
        offsetBy: contextLength,
        limitedBy: text.endIndex
      ) ?? text.endIndex

    let after = text[upperBound..<afterEnd]
    let afterLines = String(after).lines().joined("\n| ")

    let hasTrailingTruncation = afterEnd < text.endIndex

    // --- Assemble ---
    var result = "\n|\n"

    result += "| Range characters: \(middle.count)  |  String: \"\(middle)\"\n|\n"
    if hasLeadingTruncation { result += "| […]" }
    result += beforeLines
    result += highlight(String(middle))
    result += afterLines
    if hasTrailingTruncation { result += "[…]" }
    result += "\n|\n"

    return result
  }

  private func getLines(
    in text: String,
    for part: RangeBoundaryPart,
    contextLength: Int
  ) -> [Substring] {

    /// before/prefx
    /// - lowerBound
    /// - offset by *minus* contextLength
    /// - limited by startIndex
    /// - fall back to startIndex
    /// - above..<lowerbound

    /// after/suffix
    /// - upperBound
    /// - offset by  contextLength
    /// - limited by endIndex
    /// - fall back to endIndex
    /// - upperbound..<above

    let targetIndex =
      text.index(
        self[keyPath: part.boundPath],
        offsetBy: part.calculateOffset(contextLength),
        limitedBy: text.startIndex
      ) ?? text[keyPath: part.indexPath]

    let snippet = text[targetIndex..<lowerBound]
    let lines = String(snippet).lines().joined("\n| ")
  }

}

private enum RangeBoundaryPart {
  case prefix
  case suffix
}
extension RangeBoundaryPart {
  var boundPath: KeyPath<StringRange, StringRange.Bound> {
    switch self {
      case .prefix: \.lowerBound
      case .suffix: \.upperBound
    }
  }
  
  var indexPath: KeyPath<String, String.Index> {
    switch self {
      case .prefix: \.startIndex
      case .suffix: \.endIndex
    }
  }
  
  func calculateOffset(_ offset: Int) -> Int {
    switch self {
      case .prefix: offset * -1
      case .suffix: offset
    }
  }
}
