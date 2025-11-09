//
//  FrameDouble.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 30/10/2025.
//

extension Box.FrameStyle {
  public static var double: Self {
    Frame {
      // MARK: - Horizontal
      Part(.horizontal(.top)) {
        Row { Glyph.horizontal(.increased) }
        Row { Glyph.horizontal(.standard) }

      }
      Part(.horizontal(.bottom)) {
        Row { Glyph.horizontal(.standard) }
        Row { Glyph.horizontal(.increased) }
      }
      Part(.horizontal(.interior)) {
        Glyph.horizontal(.standard)
      }

      // MARK: - Vertical
      Part(.vertical(.leading)) {
        Row {
          Glyph.vertical(.increased)
          Glyph.blank
          Glyph.vertical(.standard)
        }
      }
      Part(.vertical(.trailing)) {
        Row {
          Glyph.vertical(.standard)
          Glyph.blank
          Glyph.vertical(.increased)
        }
      }
      Part(.vertical(.interior)) {
        Glyph.vertical(.standard)
      }

    }  // END Frame
    .merged(overrides: Box.JoinType.doubleJoin.parts)
    .merged(overrides: Box.CornerType.doubleCorner.parts)
  }
}
