//
//  FrameSingle.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 30/10/2025.
//

extension Box.PartType {
  //extension Box.FrameStyle {

  /// This is effectively a *conversion*, from a
  /// `PartType` to a `GlyphType`.
  ///
  /// A single-glyph Frame is quite simple, as we don't have
  /// to consider orientation, for top/bottom, or left/right.
  /// It's just the same glyph.
  ///
  /// Perhaps, in future, I will add the concept of per-axis
  /// glyph styles, but for now, these Frames have the
  /// *same glyph style* for all axes.
  func singleFrameParts(
    frameProm: Box.GlyphProminence,
    divProm: Box.GlyphProminence,
  ) -> Part {

    switch self {

      case .horizontal(.top), .horizontal(.bottom):
        Part { Box.GlyphType.horizontal(frameProm) }

      case .horizontal(.interior):
        Part {
          Box.GlyphType.horizontal(divProm)
        }

      case .vertical(.leading), .vertical(.trailing):
        Part {
          Box.GlyphType.vertical(frameProm)
        }

      case .vertical(.interior):
        Part {
          Box.GlyphType.vertical(divProm)
          Box.GlyphType.vertical(divProm)
        }

      case .join(let joinType):

      case .corner(let cornerType):
        Part {
          Box.GlyphType.corner(frameProm, type: cornerType)
        }

      case .blank:
        Part {
          Box.GlyphType.blank
        }

    }  // END switch self
  }
}

extension Box.PartType {
  fileprivate func joins(_ type: Box.JoinType) -> Part {
    
    switch type {
      case .leading, .trailing:
        Part {
          Box.GlyphType.join(
            x: divProm,
            y: frameProm,
            type: type
          )
        }
        
      case .top, .bottom:
        Part {
          Box.GlyphType.join(
            x: frameProm,
            y: divProm,
            type: type
          )
        }
        
      case .cross:
        Part {
          Box.GlyphType.join(
            x: divProm,
            y: divProm,
            type: type
          )
        }
    }

  }
}
