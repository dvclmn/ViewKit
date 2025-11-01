//
//  FrameStyle.swift
//  BoxCore
//
//  Created by Dave Coleman on 24/8/2024.
//

import SharedHelpers

extension Box.Theme {
  
  public enum FrameStyle: Sendable {
    case single
    case double
  }
}

extension Box.Theme.FrameStyle {
  
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


    /// Not yet implemented
    //    case intertwined

    /// This property forms a 'promise' that no single `BoxPart` should
    /// exceed either dimension (width or height) for the given
    /// `FrameStyle`, as defined below.
    ///
    /// This can also be thought of like a tile size. Any `BoxPart`
    /// exceeding this tile size is likely to break the layout in some way.
    ///
//    public var maximumGridSize: Box.Dimensions {
//      switch self {
//        case .single:
//
//          /// # Single — 1x1
//          ///
//          /// Examples:
//          ///
//          /// ```
//          /// // Top leading corner
//          ///   1
//          /// 1 ┌
//          ///
//          /// //Bottom centre join
//          ///   1
//          /// 1 ╧
//          ///
//          /// ```
//          let width: Int = 1 + 1  // One character either side
//          let height: Int = 3
//
//          return Box.Dimensions(width, height)
//
//        case .double:
//
//          /// # Double — 3x2
//          ///
//          /// Examples:
//          ///
//          /// ```
//          /// // Top leading corner, 3x2
//          ///
//          ///   123
//          /// 1 ┏━━
//          /// 2 ┃ ┏
//          ///
//          ///
//          /// // Bottom centre join 1x2
//          /// // Does not exceed 3x2
//          ///
//          ///   1
//          /// 1 ┷
//          /// 2 ═
//          ///
//          /// ```
//          let width: Int = 3 + 3  // One character either side
//          let height: Int = 5
//
//          return Box.Dimensions(width, height)
//
//      }
//    }

  

