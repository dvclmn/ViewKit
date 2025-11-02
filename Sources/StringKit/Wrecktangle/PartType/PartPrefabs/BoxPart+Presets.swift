//
//  PartBuilder.swift
//  BoxCore
//
//  Created by Dave Coleman on 12/9/2024.
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
  public typealias GlyphStack = [[GlyphType]]
}

/// Note: these are not so much visual/styling presets.
/// They are more from the fabrication perspective.
/// This many by this many, or something.
///
/// No 'this fun glyph', and this one, and so on.
extension Box.PartType {
  
  public func glyphStack(
    for frameStyle: Box.Theme.FrameStyle
  ) -> Box.GlyphStack {
    switch frameStyle {
      case .single: frameStackSingle
      case .double: frameStackDouble
    }
  }
}
