//
//  GlyphStack.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 3/11/2025.
//


extension Box {
  /// The output of a ``Box/PartType``.
  ///
  /// A 2D array of Glyphs. A Stack must have the same
  /// number of Glyphs in each Row; aka equal number
  /// of Characters per line. This allows a neat 'dimensions'
  /// notation, like 3x2 and so on.
  ///
  /// ```
  /// 123
  /// 456
  ///
  /// ```
  /// `GlyphStack`s are stitched together with other
  /// Stacks and characters, to form a cohesive whole.
  public typealias GlyphStack = [[Box.GlyphType]]
  
//  public typealias Line = StringStack
}
