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

    case literal(Character)  // Mostly for debugging
  }
}
