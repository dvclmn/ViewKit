//
//  FrameDouble.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 30/10/2025.
//

extension Box.FrameStyle {
  public static var double: Self {
    Frame {
      Part(.horizontal(.top)) {
        Row { Glyph.h(.increased) }
        Row { Glyph.h(.standard) }
      }

      Part(.horizontal(.bottom)) {
        Row { Glyph.h(.standard) }
        Row { Glyph.h(.increased) }
      }
      Part(.horizontal(.interior)) {
        Glyph.h(.standard)
      }

      // MARK: - Vertical
      Part(.vertical(.leading)) {
        Row {
          Glyph.v(.increased)
          Glyph.blank
          Glyph.v(.standard)
        }
      }
      Part(.vertical(.trailing)) {
        Row {
          Glyph.v(.standard)
          Glyph.blank
          Glyph.v(.increased)
        }
      }
      Part(.vertical(.interior)) {
        Glyph.v(.standard)
      }

    }  // END Frame
    .merged(overrides: Box.JoinType.doubleJoin.parts)
    .merged(overrides: Box.CornerType.doubleCorner.parts)
  }
}
