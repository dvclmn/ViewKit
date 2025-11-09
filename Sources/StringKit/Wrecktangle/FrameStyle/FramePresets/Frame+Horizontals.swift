//
//  Frame+Horizontals.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 8/11/2025.
//

extension Box.FrameStyle {
  
  public static var horizontals: Self {
    Frame {
      Part(.horizontal(.top)) { Glyph.horizontal(.increased) }
      Part(.horizontal(.bottom)) { Glyph.horizontal(.increased) }
      Part(.horizontal(.interior)) { Glyph.horizontal(.standard) }
    }
  }
}
