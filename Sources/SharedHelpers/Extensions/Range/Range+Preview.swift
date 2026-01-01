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

    let middle = text[self]

    /// Put it all together
    let indent = String(indentCharacter)
    let beforeLines = beforePart.lines.joined(separator: indent + " ")
    let afterLines = afterPart.lines.joined(separator: indent + " ")
    let newLine = "\n\(indent)\n"

    let result: [String?] = [
      newLine,
      "\(indent) Range characters: \(middle.count)  |  String: \"\(middle)\"\n\(indent)\n",
      beforePart.requiresTruncation ? "\(indent) […]" : nil,
      beforeLines,
      highlight(String(middle)),
      afterLines,
      afterPart.requiresTruncation ? "\(indent) […]" : nil,
      newLine,
    ]

    return result.compactMap(\.self).joined("\n")

    //    if beforePart.requiresTruncation { result += "\(indent) […]" }
    //    result += beforePart.lines
    //    result += highlight(String(middle))
    //    result += afterLines
    //    if afterPart.requiresTruncation { result += "\(indent) […]" }
    //    result += "\n|\n"
    //
    //    return result
  }

  //  private func buildResult(
  //    before: RangeBoundary,
  //    middle: Substring,
  //    after: RangeBoundary,
  //    indent: String
  //  ) -> String {
  //
  //  }

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
    
    let index = text[keyPath: part.indexPath]
    let result =
      text.index(
        index,
        offsetBy: part.calculateOffset(contextLength),
        limitedBy: text.startIndex
      ) ?? text[keyPath: part.indexPath]
    
    print("Index: \(index), Target: \(result)")
    return result
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
