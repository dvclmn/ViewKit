//
//  Frame+Horizontals.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 8/11/2025.
//

extension Box.FrameStyle {

  public static var horizontals: Self {
    Frame {
      Part(.horizontal(.top)) { Glyph.h(.increased, .hollow) }
      Part(.horizontal(.interior)) { Glyph.h(.standard, .sharp) }
      Part(.horizontal(.bottom)) { Glyph.h(.increased, .sharp) }
    }
  }
}
