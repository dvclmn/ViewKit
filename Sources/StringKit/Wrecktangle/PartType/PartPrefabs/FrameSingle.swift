//
//  FrameSingle.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 30/10/2025.
//

extension Box.PartType {

  var frameStackSingle: Box.GlyphStack {
    let output: Box.GlyphType =
      switch self {
        case .horizontal(.top), .horizontal(.bottom):
          Box.GlyphType.horizontal(.exterior)

        case .horizontal(.interior):
          Box.GlyphType.horizontal(.interior)

        case .vertical(.leading), .vertical(.trailing):
          Box.GlyphType.vertical(.exterior)

        case .vertical(.interior):
          Box.GlyphType.vertical(.interior)

        case .join(let joinType):
          Box.GlyphType.join(x: .exterior, y: .exterior, type: joinType)

        case .corner(let cornerType):
          Box.GlyphType.corner(location: .exterior, type: cornerType)

        case .blank:
          Box.GlyphType.blank

      }  // END switch self

    return [[output]]
  }
}
