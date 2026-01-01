//
//  Range+Preview.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 1/1/2026.
//

import Foundation

extension Range where Bound == String.Index {
  public func debugPreview(
    in text: String,
    contextLength: Int = 30,
    highlight: (String) -> String = { "░\($0)░" }
  ) -> String {
    
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
  
  private func getLines(for part: RangePart) -> [Substring] {
    
    
    let beforeStart =
    text.index(
      lowerBound,
      offsetBy: -contextLength,
      limitedBy: text.startIndex
    ) ?? text.startIndex
    
    let before = text[beforeStart..<lowerBound]
    let beforeLines = String(before).lines().joined("\n| ")
  }
  
  private enum RangePart {
    case prefix
    case suffix
  }
}
