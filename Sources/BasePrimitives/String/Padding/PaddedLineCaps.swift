//
//  PadLine.swift
//  TextCore
//
//  Created by Dave Coleman on 29/8/2024.
//

import Foundation

public enum TextPadAlignment: Sendable, Hashable {
  case leading
  case centre
  case trailing
}

public enum OddPaddingPolicy: Sendable, Hashable {
  case reduce  // shrink width by 1 to make padding even
  case expand  // grow width by 1 to make padding even
  case tolerate  // accept uneven sides (current behavior)
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

public struct LinePadOptions: Sendable, Hashable {
  public var width: Int
  public var pad: Character
  public var alignment: TextPadAlignment
  public var splitOn: Character?
  public var omitEmptySplits: Bool
  public var caps: LineCaps?
  public var surroundSpaces: SurroundSpaces
  public var oddPaddingPolicy: OddPaddingPolicy

  public init(
    width: Int,
    pad: Character = " ",
    alignment: TextPadAlignment = .centre,
    splitOn: Character? = nil,
    omitEmptySplits: Bool = true,
    caps: LineCaps? = nil,
    surroundSpaces: SurroundSpaces = .none,
    oddPaddingPolicy: OddPaddingPolicy = .reduce
  ) {
    self.width = width
    self.pad = pad
    self.alignment = alignment
    self.splitOn = splitOn
    self.omitEmptySplits = omitEmptySplits
    self.caps = caps
    self.surroundSpaces = surroundSpaces
    self.oddPaddingPolicy = oddPaddingPolicy
  }
}

extension String {
  public func paddedLine(_ options: LinePadOptions) -> String {
    let width = options.width
    let pad = options.pad

    /// If width is too small, return the original input unchanged (no clipping).
    /// (This matches what you’ve already changed.)
    /// Note: we evaluate “too small” later after computing minWidth; this early return
    /// is only for obviously invalid widths.
    if width <= 0 { return self }

    /// Build cap strings (including optional cap-adjacent spaces)
    let (capLeading, capTrailing): (String, String) = {
      guard let caps = options.caps else { return ("", "") }
      let spacer = caps.padWithSpace ? " " : ""
      return (caps.leading + spacer, spacer + caps.trailing)
    }()

    /// Determine split mode
    let pieces: [Substring]
    let isSplitMode: Bool
    if let split = options.splitOn, self.contains(split) {
      let parts = self.split(
        separator: split,
        omittingEmptySubsequences: options.omitEmptySplits
      )
      pieces = parts.isEmpty ? [self[...]] : parts
      isSplitMode = pieces.count > 1
    } else {
      pieces = [self[...]]
      isSplitMode = false
    }

    let gaps = max(0, pieces.count - 1)
    let contentWidth = pieces.reduce(0) { $0 + $1.count }

    /// Decide surround-space behaviour
    let wantsWholeBookends: Bool =
      switch options.surroundSpaces {
        case .none, .aroundSplitGaps: false
        case .aroundWholeText, .both: true
      }

    let wantsGapBookends: Bool =
      switch options.surroundSpaces {
        case .none, .aroundWholeText: false
        case .aroundSplitGaps, .both: true
      }

    /// Compute the minimum width required before we can add any pad characters.
    /// - Whole-text bookends add 2 spaces total, only when NOT split.
    /// - Gap bookends add 2 spaces per gap, only when split.
    let wholeBookendWidth = (!isSplitMode && wantsWholeBookends) ? 2 : 0
    let gapBookendWidth = (isSplitMode && wantsGapBookends) ? (2 * gaps) : 0

    let minWidth =
      capLeading.count + capTrailing.count
      + contentWidth
      + wholeBookendWidth
      + gapBookendWidth

    if width < minWidth {
      return self
    }

    let availablePadding = width - minWidth

    guard isSplitMode else {

      var effectivePadding = availablePadding
      if options.alignment == .centre && (availablePadding % 2 != 0) {
        switch options.oddPaddingPolicy {
          case .tolerate:
            break  // keep as-is
          case .reduce:
            // Only reduce if we won’t violate the minimum width.
            if effectivePadding > 0 { effectivePadding -= 1 }
          case .expand:
            effectivePadding += 1
        }
      }

      /// No split: distribute left/right padding via alignment
      let (left, right) = distributePadding(options.alignment, padding: effectivePadding)

      return capLeading
        + String(repeating: pad, count: left)
        + (wantsWholeBookends ? " " : "")
        + self
        + (wantsWholeBookends ? " " : "")
        + String(repeating: pad, count: right)
        + capTrailing
    }

    /// Distribute padding over gaps
    let perGap = gaps == 0 ? 0 : (availablePadding / gaps)
    let leftover = gaps == 0 ? 0 : (availablePadding % gaps)

    var out = capLeading

    for (idx, piece) in pieces.enumerated() {
      out += piece

      if idx < gaps {
        let padCount = perGap + (idx < leftover ? 1 : 0)

        if wantsGapBookends { out += " " }
        out += String(repeating: pad, count: padCount)
        if wantsGapBookends { out += " " }
      }
    }

    out += capTrailing
    return out
  }

  private func distributePadding(_ alignment: TextPadAlignment, padding: Int) -> (left: Int, right: Int) {
    switch alignment {
      case .leading: return (0, padding)
      case .trailing: return (padding, 0)
      case .centre:
        let left = padding / 2
        return (left, padding - left)
    }
  }
}
