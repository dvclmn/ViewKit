//
//  FrameSingle.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 30/10/2025.
//

extension Box.PartType {

  /// This is effectively a *conversion*, from a
  /// `PartType` to a `GlyphType`.
  /// 
  /// A single-glyph Frame is quite simple, as we don't have
  /// to consider orientation, for top/bottom, or left/right.
  /// It's just the same glyph.
  ///
  /// Perhaps, in future, I will add the concept of per-axis
  /// glyph styles, but for now, these Frames have the
  /// *same glyph style* for all axes.
  var frameStackSingle: Box.GlyphStack {
    let output: Box.GlyphType =
      switch self {
          
        case .horizontal(.top), .horizontal(.bottom):
          Box.GlyphType.horizontal(.bold)

        case .horizontal(.interior):
          Box.GlyphType.horizontal(.thin)

        case .vertical(.leading), .vertical(.trailing):
          Box.GlyphType.vertical(.bold)

        case .vertical(.interior):
          Box.GlyphType.vertical(.thin)

        case .join(let joinType):
          Box.GlyphType.join(weightX: .bold, weightY: .bold, type: joinType)

        case .corner(let cornerType):
          Box.GlyphType.corner(.bold, type: cornerType)

        case .text(let string):
          Box.GlyphType.text(string)
          
        case .blank:
          Box.GlyphType.blank

      }  // END switch self

    return [[output]]
  }
}
