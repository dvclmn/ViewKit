//
//  GlyphStack.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 3/11/2025.
//

extension Box {
  /// The output of a `Part`.
  ///
  /// A 2D array of Glyphs. Is resolved to a `StringStack`,
  /// which is a similar grid shape, but more primitive: `[[Character]]`
  ///
  /// `GlyphStack`s are stitched together with other
  /// Stacks and characters, to form a cohesive whole.
  public typealias GlyphStack = [[Glyph]]

}
