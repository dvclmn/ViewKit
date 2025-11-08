//
//  FrameSingle.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 30/10/2025.
//

extension Box.FrameStyle {
  public static var single: Self {
    Frame {
      Part(.horizontal(.top)) { Glyph.horizontal(.increased) }
      Part(.horizontal(.bottom)) { Glyph.horizontal(.increased) }
      Part(.horizontal(.interior)) { Glyph.horizontal(.standard) }
    }
  }
}

//extension Box.PartType {

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
//  func singleFrameParts() -> Part {
//
//    switch self {
//
//      case .horizontal(.top), .horizontal(.bottom):
//        Part { Box.GlyphType.horizontal(.increased) }
//
//      case .horizontal(.interior):
//        Part { Box.GlyphType.horizontal(.standard) }
//
//      case .vertical(.leading), .vertical(.trailing):
//        Part { Box.GlyphType.vertical(.increased) }
//
//      case .vertical(.interior):
//        Part {
//          Box.GlyphType.vertical(.standard)
//          Box.GlyphType.vertical(.standard)
//        }
//
//      case .join(let joinType):
//        join(joinType)
//
//      case .corner(let cornerType):
//        Part { Box.GlyphType.corner(.increased, type: cornerType) }
//
//      case .blank:
//        Part { Box.GlyphType.blank }
//
//    }  // END switch self
//  }
//}

//extension Box.PartType {
//  fileprivate func join(_ type: Box.JoinType) -> Part {
//
//    switch type {
//      case .leading, .trailing:
//        Part {
//          Box.GlyphType.join(
//            x: .standard,
//            y: .increased,
//            type: type
//          )
//        }
//
//      case .top, .bottom:
//        Part {
//          Box.GlyphType.join(
//            x: .increased,
//            y: .standard,
//            type: type
//          )
//        }
//
//      case .cross:
//        Part {
//          Box.GlyphType.join(
//            x: .standard,
//            y: .standard,
//            type: type
//          )
//        }
//    }
//
//  }
//}
