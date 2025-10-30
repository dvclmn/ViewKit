//
//  FrameDouble.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 30/10/2025.
//

extension Box.PartType {

  func frameDouble() -> Box.GlyphStack {

    let output: Box.GlyphStack

    switch self {

      case .horizontal(.top):
        output = [
          [Box.GlyphType.horizontal(.exterior)],
          [Box.GlyphType.horizontal(.interior)],
        ]

      case .horizontal(.bottom):
        output = [
          [Box.GlyphType.horizontal(.interior)],
          [Box.GlyphType.horizontal(.exterior)],
        ]

      case .horizontal(.interior):
        output = [
          [Box.GlyphType.horizontal(.interior)]
        ]

      case .vertical(.leading):
        output = [
          [
            Box.GlyphType.vertical(.exterior),
            Box.GlyphType.blank,
            Box.GlyphType.vertical(.interior),
          ]
        ]

      case .vertical(.trailing):
        output = [
          [
            Box.GlyphType.vertical(.interior),
            Box.GlyphType.blank,
            Box.GlyphType.vertical(.exterior),
          ]
        ]
      case .vertical(.interior):
        output = [
          [Box.GlyphType.vertical(.interior)]
        ]

      case .join(let joinType):
        output = joinType.glyphStack()

      case .corner(let cornerType):
        output = cornerType.glyphStack()
    }  // END switch self
    
    return output
  } // END frame double
}
