//
//  JoinPresets.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 8/11/2025.
//

typealias GlyphType = Box.GlyphType
extension Box.JoinType {

  static var doubleJoin: Frame {
    Frame {
      Part(.join(.leading)) {
        Row {
          GlyphType.v(.increased)
          GlyphType.blank
          GlyphType.join(
            x: .standard,
            y: .standard,
          )
        }
      }

      Part(.join(.trailing)) {
        Row {
          GlyphType.join(
            x: .standard,
            y: .standard,
          )
          GlyphType.blank
          GlyphType.v(.increased)
        }
      }

      Part(.join(.top)) {
        Row {
          GlyphType.h(.increased)
          GlyphType.blank
          GlyphType.join(
            x: .standard,
            y: .standard,
          )
        }
      }

      Part(.join(.bottom)) {
        Row {
          GlyphType.join(
            x: .standard,
            y: .standard,
          )
          GlyphType.blank
          GlyphType.h(.increased)
        }
      }

      Part(.join(.cross)) {
        Row {
          GlyphType.join(
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
          GlyphType.corner(.increased)
          GlyphType.h(.increased)
          GlyphType.h(.increased)
        }
        Row {
          GlyphType.v(.increased)
          GlyphType.blank
          GlyphType.corner(.standard)
        }
      }

      Part(.corner(.topTrailing)) {
        Row {
          GlyphType.h(.increased)
          GlyphType.h(.increased)
          GlyphType.corner(.increased)
        }
        Row {
          GlyphType.corner(.standard)
          GlyphType.blank
          GlyphType.v(.increased)
        }
      }

      Part(.corner(.bottomLeading)) {
        Row {
          GlyphType.v(.increased)
          GlyphType.blank
          GlyphType.corner(.standard)
        }

        Row {
          GlyphType.corner(.increased)
          GlyphType.h(.increased)
          GlyphType.h(.increased)
        }
      }

      Part(.corner(.bottomTrailing)) {
        Row {
          GlyphType.corner(.standard)
          GlyphType.blank
          GlyphType.v(.increased)
        }

        Row {
          GlyphType.h(.increased)
          GlyphType.h(.increased)
          GlyphType.corner(.increased)
        }
      }
    }
  }
}
