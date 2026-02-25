//
//  GridSizeMode.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 25/2/2026.
//

import CoreTools
import SwiftUI

/// `fill(size: CGSize)` is ambiguous about which size, or what size means
///
/// Should probably clarify, or be specific at call sites;
/// - Passing a `containerSize`, means “grid that fills the viewport”.
/// - Passing a `contentSize`, means “grid that matches the content extent”.
public enum GridSizeMode {
  case fixed(columns: Int, rows: Int)
  case fill(size: CGSize)

  /// To be used in a context where a Canvas view `size` can be passed in
  case fillContainer
}

extension GridSizeMode {
  
  /// Should cellSize be before or after zoom? I'm not sure
  public func gridSize(
    from cellSize: CGSize,
    in containerSize: CGSize
  ) -> UnitSize? {
    switch self {
      case .fixed(let columns, let rows):
        UnitSize(width: columns, height: rows, unitSize: cellSize)

      case .fill(let size):
        UnitSize(fromSize: size, unitSize: cellSize)

      case .fillContainer:
        UnitSize(fromSize: containerSize, unitSize: cellSize)
    }
  }
}
