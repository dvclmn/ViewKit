//
//  PartType.swift
//  BoxCore
//
//  Created by Dave Coleman on 13/9/2024.
//

extension Box {

  /// The building block used by ``Box/PartType``.
  /// Refers to a *single character* (glyph) only.
  /// Distinct from ``Box/PartType``, which handles
  /// a composite of glyphs to form a useful whole.
  ///
  /// GlyphType example:
  /// ```
  /// Horizontal: ━, ─, ︶, ┄
  /// ```
  public enum GlyphType: Hashable, Sendable, Codable {

    case horizontal(Placement)
    case vertical(Placement)

    case join(
      x: Placement,
      y: Placement,
      type: Box.PartType.Join
    )
    case corner(
      location: Placement = .exterior,
      type: Box.PartType.Corner
    )
    case blank
  }
}

/// I have turned this off, as I think the below is better-expressed
/// as 'try the *other* Placement type, as a fallback'
//extension Box.GlyphType {
//  var fallback: Box.GlyphType? {
//    switch self {
//      case .horizontal(.interior):
//        return .horizontal(.exterior)
//
//      case .vertical(.interior):
//        return .vertical(.exterior)
//
//      case .join(_, _, let type):
//        return .join(x: .exterior, y: .exterior, type: type)
//
//      case .corner(_, let type):
//        /// Default to top-leading corner
//        return .corner(location: .exterior, type: type)
//
//      default:
//        return nil
//    }
//  }
//}


