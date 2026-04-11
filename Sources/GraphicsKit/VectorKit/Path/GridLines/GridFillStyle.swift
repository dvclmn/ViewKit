//
//  GridSizeMode.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 25/2/2026.
//

import BasePrimitives
import BaseTools
import GridPrimitives
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
  func gridDimensions(
    from cellSize: CGSize,
    in containerSize: CGSize
  ) -> GridDimensions? {
    switch self {
      case .fixed(let columns, let rows):
        guard columns > 0, rows > 0 else { return nil }
        return GridDimensions(width: columns, height: rows)

      case .fill(let size):
        return size.toGridDimensions(using: cellSize)

      case .fillContainer:
        return containerSize.toGridDimensions(using: cellSize)
    }
  }
}
