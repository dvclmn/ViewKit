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
    indentCharacter: Character = "|",
    highlight: (String) -> String = { "░\($0)░" }
  ) -> String {

    guard !text.isEmpty else { return "" }

    let indent = String(indentCharacter) + " "
    let newLine = "\n\(indentCharacter)\n"
    let joinSeparator = "\n\(indent)"
    let trunc = "[…]"

    let beforeIndex =
      text.index(
        lowerBound,
        offsetBy: -contextLength,
        limitedBy: text.startIndex
      ) ?? text.startIndex

    let before = text[beforeIndex..<lowerBound]
    let beforeLines = String(before).lines().joined(joinSeparator)
    let hasLeadingTruncation = beforeIndex > text.startIndex

    let afterIndex =
      text.index(
        upperBound,
        offsetBy: contextLength,
        limitedBy: text.endIndex
      ) ?? text.endIndex

    let after = text[upperBound..<afterIndex]
    let afterLines = String(after).lines().joined(joinSeparator)
    let hasTrailingTruncation = afterIndex < text.endIndex

    let middle = text[self]

    /// Put it all together

    let result: [String?] = [

      "Range characters: \(middle.count)  |  String: \"\(middle)\"\n|\n",

      hasLeadingTruncation ? indent + trunc : nil,
      beforeLines,
      highlight(String(middle)),
      afterLines,
      hasTrailingTruncation ? trunc : nil,
      newLine,
    ]
    
    return result.compactMap(\.self).joined("\n")

  
  }

}

//private struct RangeBoundary {
//  let index: String.Index
//  let lines: [Substring]
//  let requiresTruncation: Bool
//}
//
//extension RangeBoundary {
//  static func make(
//    for part: RangeBoundaryPart,
//    range: StringRange,
//    in text: String,
//    contextLength: Int,
//  ) -> RangeBoundary {
//    let targetIndex = range.targetIndex(
//      in: text,
//      for: part,
//      contextLength: contextLength
//    )
//    return RangeBoundary(
//      index: targetIndex,
//      lines: range.getLines(in: text, for: part, contextLength: contextLength),
//      requiresTruncation: part.requiresTruncation(for: targetIndex, in: text)
//    )
//  }
//
//}

//extension Range where Bound == String.Index {
//
//  fileprivate func getLines(
//    in text: String,
//    for part: RangeBoundaryPart,
//    contextLength: Int,
//  ) -> [Substring] {
//
//    let targetIndex = targetIndex(
//      in: text,
//      for: part,
//      contextLength: contextLength
//    )
//    let range = part.makeRange(from: targetIndex, in: self)
//    let snippet = text[range]
//    let lines = String(snippet).substringLines()
//    return lines
//  }

//  fileprivate func targetIndex(
//    in text: String,
//    for part: RangeBoundaryPart,
//    contextLength: Int,
//  ) -> String.Index {
//
//    let baseIndex = text[keyPath: part.indexPath]
//    let offset = part.calculateOffset(contextLength)
//    var result: String.Index
//
//    if offset < 0 {
//      result = text.index(baseIndex, offsetBy: offset, limitedBy: text.startIndex) ?? text.startIndex
//    } else {
//      result = text.index(baseIndex, offsetBy: offset, limitedBy: text.endIndex) ?? text.endIndex
//    }
//
//    // Ensure it's in-bounds for all operations:
//    if result < text.startIndex { result = text.startIndex }
//    if result > text.endIndex { result = text.endIndex }
//    return result
//  }
//}

private enum RangeBoundaryPart {
  case prefix
  case suffix
}
extension RangeBoundaryPart {
  //  var boundPath: KeyPath<StringRange, StringRange.Bound> {
  //    switch self {
  //      case .prefix: \.lowerBound
  //      case .suffix: \.upperBound
  //    }
  //  }
  //
  //  var indexPath: KeyPath<String, String.Index> {
  //    switch self {
  //      case .prefix: \.startIndex
  //      case .suffix: \.endIndex
  //    }
  //  }

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
