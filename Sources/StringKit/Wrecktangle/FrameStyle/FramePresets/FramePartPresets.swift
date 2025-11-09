//
//  JoinPresets.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 8/11/2025.
//

extension Box.JoinType {
  static var doubleJoin: Frame {
    Frame {
      Part(.join(.leading)) {
        Row {
          Glyph.v(.increased)
          Glyph.blank
          Glyph.join(
            x: .standard,
            y: .standard,
          )
        }
      }

      Part(.join(.trailing)) {
        Row {
          Glyph.join(
            x: .standard,
            y: .standard,
          )
          Glyph.blank
          Glyph.v(.increased)
        }
      }

      Part(.join(.top)) {
        Row {
          Glyph.h(.increased)
          Glyph.blank
          Glyph.join(
            x: .standard,
            y: .standard,
          )
        }
      }

      Part(.join(.bottom)) {
        Row {
          Glyph.join(
            x: .standard,
            y: .standard,
          )
          Glyph.blank
          Glyph.h(.increased)
        }
      }

      Part(.join(.cross)) {
        Row {
          Glyph.join(
            x: .standard,
            y: .standard,
          )
        }
      }
    }
  }
}

extension Box.CornerType {
  static var doubleCorner: Frame {
    Frame {
      // MARK: - Corner

      Part(.corner(.topLeading)) {
        Row {
          Glyph.corner(.increased)
          Glyph.h(.increased)
          Glyph.h(.increased)
        }
        Row {
          Glyph.v(.increased)
          Glyph.blank
          Glyph.corner(.standard)
        }
      }

      Part(.corner(.topTrailing)) {
        Row {
          Glyph.h(.increased)
          Glyph.h(.increased)
          Glyph.corner(.increased)
        }
        Row {
          Glyph.corner(.standard)
          Glyph.blank
          Glyph.v(.increased)
        }
      }

      Part(.corner(.bottomLeading)) {
        Row {
          Glyph.v(.increased)
          Glyph.blank
          Glyph.corner(.standard)
        }

        Row {
          Glyph.corner(.increased)
          Glyph.h(.increased)
          Glyph.h(.increased)
        }
      }

      Part(.corner(.bottomTrailing)) {
        Row {
          Glyph.corner(.standard)
          Glyph.blank
          Glyph.v(.increased)
        }

        Row {
          Glyph.h(.increased)
          Glyph.h(.increased)
          Glyph.corner(.increased)
        }
      }
    }
  }
}
