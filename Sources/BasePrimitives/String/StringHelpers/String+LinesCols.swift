//
//  String+LinesCols.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 21/11/2025.
//

#if canImport(AppKit)
import AppKit
import Foundation

extension String {

  public func countLinesAndColumns(in range: NSRange) -> (line: Int, column: Int) {
    self.countLinesAndColumns(upTo: range.location)
  }

  /// Counts lines and columns up to a safe target position
  public func countLinesAndColumns(
    upTo targetLocation: Int,
  ) -> (line: Int, column: Int) {
    var lineNumber = 1
    var columnNumber = 1
    var currentIndex = 0

    let safeLimit = min(targetLocation, self.count)

    while currentIndex < safeLimit {
      if self.isNewLine(at: currentIndex) {
        lineNumber += 1
        columnNumber = 1
      } else {
        columnNumber += 1
      }
      currentIndex += 1
    }

    return (lineNumber, columnNumber)
  }

  private func isNewLine(
    at offset: Int
  ) -> Bool {
    self.element(at: offset) == "\n"
  }

  public func countNewlines(in range: NSRange) -> Int {
    self.countNewlines(
      from: range.location,
      to: range.location + range.length
    )
  }

  public func countNewlines(
    from start: Int,
    to end: Int
  ) -> Int {
    var count = 1
    let safeEnd = min(end, self.count)

    var currentIndex = max(start, 0)
    while currentIndex < safeEnd {
      if self.isNewLine(at: currentIndex) {
        count += 1
      }
      currentIndex += 1
    }
    return count
  }
}
#endif
