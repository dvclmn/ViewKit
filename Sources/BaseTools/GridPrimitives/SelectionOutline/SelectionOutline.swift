//
//  SelectionOutline.swift
//  BaseHelpers
//
//  Created by Codex on 22/3/2026.
//

import Foundation

/// A segment along the grid lattice (cell corner to cell corner),
/// used for outlining a set of selected grid cells.
public struct GridOutlineSegment: Hashable, Sendable {
  public let x1: Int
  public let y1: Int
  public let x2: Int
  public let y2: Int

  public init(_ x1: Int, _ y1: Int, _ x2: Int, _ y2: Int) {
    /// Normalise so identical segments hash the same.
    if x1 < x2 || (x1 == x2 && y1 < y2) {
      self.x1 = x1
      self.y1 = y1
      self.x2 = x2
      self.y2 = y2
    } else {
      self.x1 = x2
      self.y1 = y2
      self.x2 = x1
      self.y2 = y1
    }
  }
}

public enum GridSelectionOutline {

  /// Returns the outer perimeter of a set of selected cells, expressed as
  /// lattice segments between cell corners. Internal shared edges cancel out.
  public static func segments(
    from selected: Set<GridPosition>
  ) -> Set<GridOutlineSegment> {
    var edges = Set<GridOutlineSegment>()
    for pos in selected {
      let c = pos.column
      let r = pos.row

      /// Four edges of the cell in lattice coordinates
      let top = GridOutlineSegment(c, r, c + 1, r)
      let bottom = GridOutlineSegment(c, r + 1, c + 1, r + 1)
      let left = GridOutlineSegment(c, r, c, r + 1)
      let right = GridOutlineSegment(c + 1, r, c + 1, r + 1)

      for e in [top, bottom, left, right] {
        if edges.contains(e) {
          /// shared edge -> internal -> cancel
          edges.remove(e)
        } else {
          edges.insert(e)
        }
      }
    }
    return edges
  }
}
