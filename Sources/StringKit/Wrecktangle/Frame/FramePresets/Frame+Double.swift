//
//  FrameDouble.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 30/10/2025.
//

/// Note: Order doesn't matter in a `Frame` builder, like it
/// does in a `Part`/`Row` builder. Definitions just need
/// to be present, not expressed in a specific order.
extension Box.FrameStructure {
  public static var double: Self {
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

      //      Part.doubleJoin

      //      Part.doubleJoin
      //      PartGroup.doubleCorner

    }  // END Frame
    //    .merged(with: Part.doubleJoin)
    //    .merged(with: Part.doubleCorner)
  }
}
