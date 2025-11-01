//
//  FrameDouble.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 30/10/2025.
//

extension Box.PartType {

  var frameStackDouble: Box.GlyphStack {

    switch self {

      case .horizontal(.top):
        [
          [Box.GlyphType.horizontal(.exterior)],
          [Box.GlyphType.horizontal(.interior)],
        ]

      case .horizontal(.bottom):
        [
          [Box.GlyphType.horizontal(.interior)],
          [Box.GlyphType.horizontal(.exterior)],
        ]

      case .horizontal(.interior):
        [[Box.GlyphType.horizontal(.interior)]]

      case .vertical(.leading):
        [
          [
            Box.GlyphType.vertical(.exterior),
            Box.GlyphType.blank,
            Box.GlyphType.vertical(.interior),
          ]
        ]

      case .vertical(.trailing):
        [
          [
            Box.GlyphType.vertical(.interior),
            Box.GlyphType.blank,
            Box.GlyphType.vertical(.exterior),
          ]
        ]
      case .vertical(.interior):
        [[Box.GlyphType.vertical(.interior)]]

      case .join(let joinType):
        joinType.glyphStack()

      case .corner(let cornerType):
        cornerType.glyphStack()
        
      case .blank:
        [[Box.GlyphType.blank]]
        
    }  // END switch self

  }  // END frame double
}
