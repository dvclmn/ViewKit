//
//  FrameStyle.swift
//  BoxCore
//
//  Created by Dave Coleman on 24/8/2024.
//

import SharedHelpers

extension Box {
  public enum FrameStyle: Sendable, Codable, Equatable {

    case single(
      frame: Prominence = .increased,
      dividers: Prominence = .standard
    )

    case double(
      exterior: Prominence = .increased,
      interior: Prominence = .standard
    )
  }
}

extension Box.FrameStyle {

  /// The width and height reserved for structure,
  /// unable to be used by content.
  ///
  /// Relevant for fixed only, i think? Not repeating?
  /// This should account for glyphs on *both* sides of the relevant axis?
  /// This is why it's returned as `doubled`
  public var reservedDimensions: GridDimensions {
    switch self {
      /// Each glyph, either side (leading-trailing, or top-bottom)
      case .single:
        let widthAndHeight = 1
        return GridDimensions(widthAndHeight, widthAndHeight).doubled

      case .double:
        let width = 3
        let height = 2
        return GridDimensions(width, height).doubled
    }
  }
}
