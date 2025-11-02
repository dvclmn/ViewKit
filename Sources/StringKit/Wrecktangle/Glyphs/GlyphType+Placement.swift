//
//  GlyphType+Placement.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 1/11/2025.
//

extension Box.GlyphType {
  
  /// Trying to improve how Boxes are constructed, and what the
  /// instructions for the Builder look like. Balancing delcarative, and
  /// imperative.
  ///
  /// ## Repeating Parts
  /// Would be neat to create an API to provide a
  /// horizontal / vertical / either build block (`Part`),
  /// and have it be stitched together and repeated.
  /// Could make for some fun, even emergent frame styles.
  ///
  /// Do I make the API *dimension-first*, where you can supply
  /// whatever construction of characters you, as long as the dimensions
  /// are correct (e.g. `1x2`, `4x5`, whatever). This provides
  /// perhaps more creative control, but places more responsibility
  /// on the theme designer, to get the parts matching up right.
  /// More user-error prone.
  ///
  /// Or, make it more declarative, where you just supply a Theme
  /// or preferred pre-fabbed GlyphSet, with some other parameters,
  /// and you 'get what you get'?

  /// Describes where this Glyph should be used, in the context
  /// of a Box structure. Typically based on interior vs exterior
  /// usage; bolder glyph weight for exterior, lighter for interior.
  public enum Placement: Hashable, Sendable, Codable {
    case interior
    case exterior
  }
}

extension Box.GlyphType.Placement {
  fileprivate var flipped: Self {
    switch self {
      case .interior: return .exterior
      case .exterior: return .interior
    }
  }
}

extension Box.GlyphType {

  /// Returns a copy of this glyph type, with its placement(s) flipped
  /// from interior <-> exterior where applicable.
  var flippedPlacement: Self? {
    switch self {
      case .horizontal(let placement):
        return .horizontal(placement.flipped)

      case .vertical(let placement):
        return .vertical(placement.flipped)

      case .corner(let location, let type):
        return .corner(location: location.flipped, type: type)

      case .join(let x, let y, let type):
        return .join(x: x.flipped, y: y.flipped, type: type)

      case .blank:
        return nil
    }
  }
}
