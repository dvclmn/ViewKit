//
//  FrameSingle.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 30/10/2025.
//

extension BoxPart.PartType {

  func frameSingle() -> GlyphStack {

    let output: Glyph

    switch self {

      case .horizontal(.top), .horizontal(.bottom):
        output = Glyph.horizontal(.exterior)

      case .horizontal(.interior):
        output = Glyph.horizontal(.interior)

      case .vertical(.leading), .vertical(.trailing):
        output = Glyph.vertical(.exterior)

      case .vertical(.interior):
        output = Glyph.vertical(.interior)

      case .join(let joinType):
        output = Glyph.join(x: .exterior, y: .exterior, type: joinType)

      case .corner(let cornerType):
        output = Glyph.corner(location: .exterior, type: cornerType)

    }  // END switch self

    return [[output]]
  }
}
