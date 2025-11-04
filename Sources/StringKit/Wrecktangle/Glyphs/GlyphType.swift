//
//  PartType.swift
//  BoxCore
//
//  Created by Dave Coleman on 13/9/2024.
//

import EnumMacros
import Foundation

extension Box {

  /// The building block used by ``Box/PartType``.
  /// Refers to a *single character* (glyph) only.
  /// Distinct from ``Box/PartType``, which handles
  /// a composite of glyphs to form a useful whole.
  ///
  /// GlyphType example:
  /// ```
  /// Horizontal: ━, ─, ︶, ┄
  /// ```
  @MetaEnum
  @CaseDetection
  public enum GlyphType: Hashable, Sendable, Codable {

    case horizontal(GlyphProminence)
    case vertical(GlyphProminence)

    case join(
      x: GlyphProminence,
      y: GlyphProminence,
      type: JoinType
    )

    case corner(GlyphProminence, type: CornerType)
    case blank

    case literal(Character) // Mostly for debugging
  }
}

extension Box.GlyphType: ExpressibleByUnicodeScalarLiteral {
  public init(unicodeScalarLiteral value: UnicodeScalar) {
    /// A simple fallback 'literal' type for debugging / placeholder
    self = .literal(Character(value))
  }
}

/// You’ve already got a really clean fallback mechanism (partial + base).
/// If you ever want more fine-grained control, one improvement might be to
/// model fallback resolution via a simple protocol rather than a manual switch.

/// That is, you could move character(for:) into a protocol like:
protocol GlyphProvider {
  func character(for type: Box.GlyphType) -> Character?
}

/// Then make both GlyphMap and GlyphSet conform, so GlyphSet
/// can compose multiple sources more generically.
/// It’s almost the same logic — but it means GlyphSet could later be composed
/// dynamically from multiple sources, like a theme stack, not just nested .partial.
extension Box.GlyphSet: GlyphProvider {
  func character(for type: Box.GlyphType) -> Character? {
    switch self {
      case .base(let glyphMap):
        return glyphMap[type]
      case .partial(let glyphMap, let fallback):
        return glyphMap[type] ?? fallback.character(for: type)
    }
  }
}
