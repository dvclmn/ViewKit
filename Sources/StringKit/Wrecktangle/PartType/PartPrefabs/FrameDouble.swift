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
          [Box.GlyphType.horizontal(.bold)],
          [Box.GlyphType.horizontal(.thin)],
        ]

      case .horizontal(.bottom):
        [
          [Box.GlyphType.horizontal(.thin)],
          [Box.GlyphType.horizontal(.bold)],
        ]

      case .horizontal(.interior):
        [[Box.GlyphType.horizontal(.thin)]]

      case .vertical(.leading):
        [
          [
            Box.GlyphType.vertical(.bold),
            Box.GlyphType.blank,
            Box.GlyphType.vertical(.thin),
          ]
        ]

      case .vertical(.trailing):
        [
          [
            Box.GlyphType.vertical(.thin),
            Box.GlyphType.blank,
            Box.GlyphType.vertical(.bold),
          ]
        ]
      case .vertical(.interior):
        [[Box.GlyphType.vertical(.thin)]]

      case .join(let joinType):
        joinType.glyphStack()

      case .corner(let cornerType):
        cornerType.glyphStack()
        
      case .blank:
        [[Box.GlyphType.blank]]
        
    }  // END switch self

  }  // END frame double
}
