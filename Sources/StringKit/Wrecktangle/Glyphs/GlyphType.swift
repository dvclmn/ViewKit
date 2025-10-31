//
//  PartType.swift
//  BoxCore
//
//  Created by Dave Coleman on 13/9/2024.
//

extension Box {

  /// Refers to a *single character* (glyph) only.
  /// Distinct from ``Box/PartType``, which handles
  /// a composite of glyphs to form a useful whole.
  public enum GlyphType: Hashable, Sendable {

    /// Basic lines
    case horizontal(Placement)
    case vertical(Placement)

    /// Joins
    case join(
      x: Placement,
      y: Placement,
      type: Box.PartType.Join
    )
    
    /// Corners
    case corner(
      location: Placement = .exterior,
      type: Box.PartType.Corner
    )

    case blank
  }
}

extension Box.GlyphType {
  var fallback: Box.GlyphType? {
    switch self {
      case .horizontal(.interior):
        return .horizontal(.exterior)
        
      case .vertical(.interior):
        return .vertical(.exterior)
        
      case .join(_, _, let type):
        return .join(x: .exterior, y: .exterior, type: type)
        
      case .corner(_, let type):
        /// Default to top-leading corner
        return .corner(location: .exterior, type: type)
        
      default:
        return nil
    }
  }
}

extension Box.GlyphType {
  
  /// Describes where this Glyph should be used, in the context
  /// of a Box structure. Typically based on interior vs exterior
  /// usage; bolder glyph weight for exterior, lighter for interior.
  public enum Placement: Hashable, Sendable {
    case interior
    case exterior
  }
}
