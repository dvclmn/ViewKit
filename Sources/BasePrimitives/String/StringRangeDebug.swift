//
//  StringRangeDebug.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 23/12/2025.
//

import Foundation

extension String {

  public struct RangeDebugOptions {
    var context: Int  // characters either side
    var markStart: String
    var markEnd: String
    var showLineNumbers: Bool
    var label: String?
    
    public init(
      context: Int = 40,
      markStart: String = "⟦",
      markEnd: String = "⟧",
      showLineNumbers: Bool = true,
      label: String? = nil
    ) {
      self.context = context
      self.markStart = markStart
      self.markEnd = markEnd
      self.showLineNumbers = showLineNumbers
      self.label = label
    }
  }

  public func debugContext(
    around range: Range<Index>,
    options: RangeDebugOptions = .init()
  ) -> String {

    guard range.isGreaterThanOrEqualToZero else {
      return "⚠️ Invalid range"
    }

    // Clamp context safely
    let start =
      index(
        range.lowerBound,
        offsetBy: -options.context,
        limitedBy: startIndex
      ) ?? startIndex

    let end =
      index(
        range.upperBound,
        offsetBy: options.context,
        limitedBy: endIndex
      ) ?? endIndex

    let prefix = self[start..<range.lowerBound]
    let target = self[range]
    let suffix = self[range.upperBound..<end]

    var output = ""

    if let label = options.label {
      output += "— \(label) —\n"
    }

    let marked = "\(prefix)\(options.markStart)\(target)\(options.markEnd)\(suffix)"

    if options.showLineNumbers {
      output += Self.addLineNumbers(to: String(marked), baseIndex: start, in: self)
    } else {
      output += marked
    }

    return output
  }
}

extension String {

  fileprivate static func addLineNumbers(
    to text: String,
    baseIndex: String.Index,
    in original: String
  ) -> String {

    let baseLine =
      original[..<baseIndex]
      .filter { $0 == "\n" }
      .count + 1

    return
      text
      .split(omittingEmptySubsequences: false, whereSeparator: \.isNewline)
      .enumerated()
      .map { offset, line in
        let lineNumber = baseLine + offset
        return String(format: "%4d │ %@", lineNumber, String(line))
      }
      .joined(separator: "\n")
  }
}
