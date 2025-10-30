//
//  PartType.swift
//  BoxCore
//
//  Created by Dave Coleman on 13/9/2024.
//

extension Box {

  /// I ought to make it so the code will use the external version of a glyph,
  /// if there is no internal style available?
  public enum GlyphType: Hashable, Sendable {

    /// Basic lines
    case horizontal(Location)
    case vertical(Location)

    /// Joins
    case join(x: Location, y: Location, type: BoxPart.Join)
    
    /// Corners
    case corner(
      location: Location = .exterior,
      type: BoxPart.Corner
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
  
  public enum Location: Hashable, Sendable {
    case interior
    case exterior
  }

}
