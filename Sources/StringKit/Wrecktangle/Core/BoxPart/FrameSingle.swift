//
//  FrameSingle.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 30/10/2025.
//

extension Box.PartType {
  var frameStackSingle: Box.GlyphStack {

    let output: Box.GlyphType

    switch self {

      case .horizontal(.top), .horizontal(.bottom):
        output = Box.GlyphType.horizontal(.exterior)

      case .horizontal(.interior):
        output = Box.GlyphType.horizontal(.interior)

      case .vertical(.leading), .vertical(.trailing):
        output = Box.GlyphType.vertical(.exterior)

      case .vertical(.interior):
        output = Box.GlyphType.vertical(.interior)

      case .join(let joinType):
        output = Box.GlyphType.join(x: .exterior, y: .exterior, type: joinType)

      case .corner(let cornerType):
        output = Box.GlyphType.corner(location: .exterior, type: cornerType)

    }  // END switch self

    return [[output]]
  }
}
