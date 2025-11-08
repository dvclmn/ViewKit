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

      //      // MARK: - Horizontal
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

      

      // MARK: - Corner

      Part(.corner(.topLeading)) {
        Row {
          Glyph.corner(.increased, type: .topLeading)
          Glyph.horizontal(.increased)
          Glyph.horizontal(.increased)
        }
        Row {
          Glyph.vertical(.increased)
          Glyph.blank
          Glyph.corner(.standard, type: .topLeading)
        }
      }

      Part(.corner(.topTrailing)) {
        Row {
          Glyph.horizontal(.increased)
          Glyph.horizontal(.increased)
          Glyph.corner(.increased, type: .topTrailing)
        }
        Row {
          Glyph.corner(.standard, type: .topTrailing)
          Glyph.blank
          Glyph.vertical(.increased)
        }
      }

      Part(.corner(.bottomLeading)) {
        Row {
          Glyph.vertical(.increased)
          Glyph.blank
          Glyph.corner(.standard, type: .bottomLeading)
        }

        Row {
          Glyph.corner(.increased, type: .bottomLeading)
          Glyph.horizontal(.increased)
          Glyph.horizontal(.increased)
        }
      }

      Part(.corner(.bottomTrailing)) {
        Row {
          Glyph.corner(.standard, type: .bottomTrailing)
          Glyph.blank
          Glyph.vertical(.increased)
        }

        Row {
          Glyph.horizontal(.increased)
          Glyph.horizontal(.increased)
          Glyph.corner(.increased, type: .bottomTrailing)
        }
      }

    }
  }
}
