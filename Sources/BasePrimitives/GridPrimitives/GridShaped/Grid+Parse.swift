//
//  Grid+Parse.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 27/2/2026.
//

import Foundation

/// Key points:
/// - No padding/truncation happens here.
/// - Tests can assert rows​.count, widest​Line, and had​Terminal​Newline directly.
/// - The “terminal newline becomes spaces” issue is avoided entirely at this stage.
public struct GridParseResult<Cell> {
  public let rows: [[Cell]]  // ragged, no padding
  public let hadTerminalNewline: Bool
  public let widestLine: Int
}

public struct GridParsingOptions: OptionSet, Sendable {
  public let rawValue: Int
  public init(rawValue: Int) { self.rawValue = rawValue }

  /// Keep blank lines that appear (including leading/middle)
  public static let keepBlankLines = GridParsingOptions(rawValue: 1 << 0)

  /// Treat a terminal newline as creating an extra blank row
  public static let preserveTerminalNewlineAsRow = GridParsingOptions(rawValue: 1 << 1)

  /// Default behavior could be to NOT preserve the terminal newline as an extra row
  public static let `default`: GridParsingOptions = [.keepBlankLines]
}

extension GridShaped where Cell == Character {
  /// Pure parse: no padding/truncation
  public static func parse(text: String, options: GridParsingOptions = .default) -> GridParseResult<Cell> {
    let hadTerminalNewline = text.last == "\n" || text.last == "\r\n"
    /// Use your existing `lines(omissionStrategy:)` carefully here.
    /// Convert each line to [Character] without padding.
    let split = text.lines(omissionStrategy: .doNotOmit)
    var rows = split.map { Array($0) }

    if !options.contains(.preserveTerminalNewlineAsRow), hadTerminalNewline {
      // If the trailing line exists solely due to terminal newline and is empty, drop it.
      if let last = rows.last, last.isEmpty {
        rows.removeLast()
      }
    }

    let widest = rows.map(\.count).max() ?? 0
    return .init(rows: rows, hadTerminalNewline: hadTerminalNewline, widestLine: widest)
  }
}
