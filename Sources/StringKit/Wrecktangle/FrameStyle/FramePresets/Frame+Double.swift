//
//  FrameDouble.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 30/10/2025.
//

extension Box.Frame {
  public static var double: Self {
    Frame {
      Part(.horizontal(.top)) {
        Row { GlyphType.h(.increased) }
        Row { GlyphType.h(.standard) }
      }

      Part(.horizontal(.bottom)) {
        Row { GlyphType.h(.standard) }
        Row { GlyphType.h(.increased) }
      }
      Part(.horizontal(.interior)) {
        GlyphType.h(.standard)
      }

      // MARK: - Vertical
      Part(.vertical(.leading)) {
        Row {
          GlyphType.v(.increased)
          GlyphType.blank
          GlyphType.v(.standard)
        }
      }
      Part(.vertical(.trailing)) {
        Row {
          GlyphType.v(.standard)
          GlyphType.blank
          GlyphType.v(.increased)
        }
      }
      Part(.vertical(.interior)) {
        GlyphType.v(.standard)
      }

    }  // END Frame
    .merged(overrides: Box.JoinType.doubleJoin.parts)
    .merged(overrides: Box.CornerType.doubleCorner.parts)
  }
}
