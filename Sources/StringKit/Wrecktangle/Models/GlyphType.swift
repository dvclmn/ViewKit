//
//  PartType.swift
//  BoxCore
//
//  Created by Dave Coleman on 13/9/2024.
//

extension Box {


  /// I ought to make it so the code will use the external version of a glyph,
  /// if there is no internal style available?
  ///
  public enum GlyphType: Hashable, Sendable {

    /// Basic lines
    case horizontal(Location = .exterior)
    case vertical(Location = .exterior)

    /// Joins
    case join(
      x: Location = .interior,
      y: Location = .exterior,
      type: BoxPart.Join
    )

    /// Corners
    case corner(
      location: Location = .exterior,
      type: BoxPart.Corner
    )

    case blank

    public enum Location: Hashable, Sendable {
      case interior
      case exterior
    }

    var fallback: Box.GlyphType? {
      switch self {
        case .horizontal(.interior):
          return .horizontal(.exterior)
        case .vertical(.interior):
          return .vertical(.exterior)
        case .join(_, _, let type):
          return .join(x: .exterior, y: .exterior, type: type)  // Default to cross join
        case .corner(_, let type):
          return .corner(location: .exterior, type: type)  // Default to top-leading corner

        default:
          return nil
      }
    }
  }

}
