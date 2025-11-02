//
//  PartType.swift
//  BoxCore
//
//  Created by Dave Coleman on 13/9/2024.
//

import EnumMacros
import Foundation

extension Box {
  
  
  /// Trying to improve how Boxes are constructed, and what the
  /// instructions for the Builder look like. Balancing delcarative, and
  /// imperative.
  ///
  /// ## Repeating Parts
  /// Would be neat to create an API to provide a
  /// horizontal / vertical / either build block (`Part`),
  /// and have it be stitched together and repeated.
  /// Could make for some fun, even emergent frame styles.
  ///
  /// Do I make the API *dimension-first*, where you can supply
  /// whatever construction of characters you, as long as the dimensions
  /// are correct (e.g. `1x2`, `4x5`, whatever). This provides
  /// perhaps more creative control, but places more responsibility
  /// on the theme designer, to get the parts matching up right.
  /// More user-error prone.
  ///
  /// Or, make it more declarative, where you just supply a Theme
  /// or preferred pre-fabbed GlyphSet, with some other parameters,
  /// and you 'get what you get'?


  /// The building block used by ``Box/PartType``.
  /// Refers to a *single character* (glyph) only.
  /// Distinct from ``Box/PartType``, which handles
  /// a composite of glyphs to form a useful whole.
  ///
  /// GlyphType example:
  /// ```
  /// Horizontal: ━, ─, ︶, ┄
  /// ```
  @CaseDetection
  public enum GlyphType: Hashable, Sendable, Codable {

    case horizontal(Weight)
    case vertical(Weight)

    case join(
      weightX: Weight,
      weightY: Weight,
      type: Box.JoinType
    )
    case corner(
      Weight = .bold,
      type: Box.CornerType
    )
    case text(Character)
    case blank
  }
}

