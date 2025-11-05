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
      frame: Box.GlyphProminence = .increased,
      dividers: Box.GlyphProminence = .standard
    )

    case double(
      exterior: Box.GlyphProminence = .increased,
      interior: Box.GlyphProminence = .standard
    )
    
    case notebook
  }
}

extension Box.FrameStyle {
  
  var reservedWidth: Int {
    switch self {
      case .single: 1
      case .double: 3
      case .notebook: 3
    }
  }

  /// The width and height reserved for structure,
  /// unable to be used by content.
  ///
  /// Relevant for fixed only, i think? Not repeating?
  /// This should account for glyphs on *both* sides of the relevant axis?
  /// This is why it's returned as `doubled`
//  public var reservedDimensions: (leading: GridDimensions, trailing: GridDimensions) {
////  public var reservedDimensions: GridDimensions {
//    switch self {
//      /// Each glyph, either side (leading-trailing, or top-bottom)
//      case .single:
//        let widthAndHeight = 1
//        let result = GridDimensions(widthAndHeight, widthAndHeight)
//        return (result, result)
//
//      case .double:
//        let width = 3
//        let height = 2
//        let result = GridDimensions(width, height)
//        return (result, result)
//        
//      case .notebook:
//        let leading = GridDimensions(3, 2)
//        let trailing = GridDimensions(2, 2)
//        return (leading, trailing)
//        
//    }
//  }
}
