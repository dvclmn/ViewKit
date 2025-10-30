//
//  PartType.swift
//  BoxCore
//
//  Created by Dave Coleman on 13/9/2024.
//

extension Box {

  public enum GlyphType: Hashable, Sendable {

    /// Basic lines
    case horizontal(Location)
    case vertical(Location)

    /// Joins
    case join(x: Location, y: Location, type: Box.PartType.Join)
    
    /// Corners
    case corner(
      location: Location = .exterior,
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
        /// Default to cross join
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
  
  /// This usually describes the thickness of a structural
  /// glyph; typically bolder for exterior, lighter for interior
  public enum Location: Hashable, Sendable {
    case interior
    case exterior
  }
}
