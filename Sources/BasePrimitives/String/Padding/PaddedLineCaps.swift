//
//  PadLine.swift
//  TextCore
//
//  Created by Dave Coleman on 29/8/2024.
//

import Foundation

public typealias StringCaps = (leading: String, trailing: String)

public enum TextPadAlignment: Sendable, Hashable {
  case leading
  case centre
  case trailing
}

public struct LineCaps: Sendable, Hashable {
  public var leading: String
  public var trailing: String
  public var padWithSpace: Bool

  public init(_ leading: String, _ trailing: String, padWithSpace: Bool = true) {
    self.leading = leading
    self.trailing = trailing
    self.padWithSpace = padWithSpace
  }
}

public enum PadDebugStyle: Sendable, Hashable {
  case none
  case showSpaces(space: Character = "·")
}

extension String {

  /// Pads a line to a target width.
  ///
  /// Policy:
  /// - If `splitOn` is provided *and* the string contains it, the string is split and padding is distributed across gaps.
  /// - Otherwise, padding is distributed left/right according to `alignment`.
  /// - If `toFill` is smaller than the minimum required width, the string is returned without clipping.
  public func paddedLine(
    toFill width: Int,
    pad: Character = " ",
    alignment: TextPadAlignment = .centre,
    splitOn: Character? = nil,
    caps: LineCaps? = nil,
    surroundTextWithSpaces: Bool = true,
    omitEmptySplits: Bool = true
  ) -> String {

    // Build caps
    let (capLeading, capTrailing): StringCaps = {
      guard let caps else { return ("", "") }
      let spacer = caps.padWithSpace ? " " : ""
      return (caps.leading + spacer, spacer + caps.trailing)
    }()

    // Decide whether to split
    let pieces: [Substring]
    let shouldSplit: Bool
    if let splitOn, self.contains(splitOn) {
      pieces = self.split(separator: splitOn, omittingEmptySubsequences: omitEmptySplits)
      shouldSplit = pieces.count > 1
    } else {
      pieces = [self[...]]
      shouldSplit = false
    }

    // Surround-space policy
    let surround = surroundTextWithSpaces ? " " : ""
    let surroundWidth = surround.count * 2

    // Minimum width (caps + content + (surround per piece or per gap policy))
    //
    // Chosen policy:
    // - No split: surround the whole string once.
    // - Split: surround each gap (i.e. before+after each padding run), not each piece.
    //
    // If you prefer “surround each piece”, that’s a different (valid) policy — just make it explicit.
    let contentWidth = pieces.reduce(0) { $0 + $1.count }
    let gaps = max(0, pieces.count - 1)

    let gapSurroundWidth = shouldSplit ? (surroundWidth * gaps) : 0
    let wholeSurroundWidth = shouldSplit ? 0 : surroundWidth

    let minWidth =
      capLeading.count + capTrailing.count
      + contentWidth
      + gapSurroundWidth
      + wholeSurroundWidth

    /// If too small, don’t clip; return “as assembled” without padding.
    if width <= minWidth {
      return self
//      guard shouldSplit else {
//        return capLeading + surround + self + surround + capTrailing
//      }
//      return capLeading + pieces.joined(separator: "") + capTrailing
    }

    let availablePadding = width - minWidth

    guard shouldSplit else {
      let (left, right) = distributePadding(alignment: alignment, padding: availablePadding)
      return capLeading
        + String(repeating: pad, count: left)
        + surround + self + surround
        + String(repeating: pad, count: right)
        + capTrailing
    }
    let perGap = availablePadding / gaps
    let leftover = availablePadding % gaps

    var out = capLeading

    for (idx, piece) in pieces.enumerated() {
      out += piece

      if idx < gaps {
        let thisGap = perGap + (idx < leftover ? 1 : 0)
        out += surround
        out += String(repeating: pad, count: thisGap)
        out += surround
      }
    }

    out += capTrailing
    return out
  }

  private func distributePadding(
    alignment: TextPadAlignment,
    padding: Int
  ) -> (left: Int, right: Int) {
    switch alignment {
      case .leading: return (0, padding)
      case .trailing: return (padding, 0)
      case .centre:
        let left = padding / 2
        return (left, padding - left)
    }
  }
}
