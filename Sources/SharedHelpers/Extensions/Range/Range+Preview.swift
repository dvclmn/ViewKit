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

    let beforePart = RangeBoundary.make(
      for: .prefix,
      range: self,
      in: text,
      contextLength: contextLength
    )
    
    let afterPart = RangeBoundary.make(
      for: .suffix,
      range: self,
      in: text,
      contextLength: contextLength
    )
    
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
//    let hasLeadingTruncation = beforeStart > text.startIndex
    

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

 

}

private struct RangeBoundary {
  let index: String.Index
  let lines: [Substring]
  let requiresTruncation: Bool
}

extension RangeBoundary {
  static func make(
    for part: RangeBoundaryPart,
    range: StringRange,
    in text: String,
    contextLength: Int,
  ) -> RangeBoundary {
    let targetIndex = range.targetIndex(
      in: text,
      for: part,
      contextLength: contextLength
    )
    return RangeBoundary(
      index: targetIndex,
      lines: range.getLines(in: text, for: part, contextLength: contextLength),
      requiresTruncation: part.requiresTruncation(for: targetIndex, in: text)
    )
  }

}

extension Range where Bound == String.Index {
  
  /// `separator` is what the leading 'wall' or margin should
  /// look like for each line
  fileprivate func getLines(
    in text: String,
    for part: RangeBoundaryPart,
    contextLength: Int,
  ) -> [Substring] {
    
    let targetIndex = targetIndex(
      in: text,
      for: part,
      contextLength: contextLength
    )
    let range = part.makeRange(from: targetIndex, in: self)
    let snippet = text[range]
    let lines = String(snippet).substringLines()
    return lines
  }
  
  fileprivate func targetIndex(
    in text: String,
    for part: RangeBoundaryPart,
    contextLength: Int,
  ) -> String.Index {
    text.index(
      self[keyPath: part.boundPath],
      offsetBy: part.calculateOffset(contextLength),
      limitedBy: text.startIndex
    ) ?? text[keyPath: part.indexPath]
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
  func makeRange(
    from index: StringRange.Bound,
    in range: StringRange
  ) -> StringRange {
    switch self {
      case .prefix: index..<range.lowerBound
      case .suffix: range.upperBound..<index
    }
  }

  func requiresTruncation(
    for index: String.Index,
    in text: String,
  ) -> Bool {
    switch self {
      case .prefix: index > text.startIndex
      case .suffix: index < text.endIndex
    }
  }
}
