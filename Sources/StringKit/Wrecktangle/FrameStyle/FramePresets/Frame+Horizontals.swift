//
//  Frame+Horizontals.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 8/11/2025.
//

extension Box.FrameStyle {

  public static var horizontals: Self {
    Frame {
      Part(.horizontal(.top)) {
        GlyphType.h(.increased, .hollow)
      }
      Part(.horizontal(.interior)) {
        GlyphType.h(.standard, .sharp)
      }
      Part(.horizontal(.bottom)) {
        GlyphType.h(.increased, .sharp)
      }
    }
  }
}
