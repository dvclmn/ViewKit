//
//  Builder+Draw.swift
//  BaseDemos
//
//  Created by Dave Coleman on 2/2/2026.
//

//import BasePrimitives
//import InteractionKit
//import CoreUtilities
import EnumMacros
import SwiftUI

@CaseDetection
enum RowColBoundary {
  case min
  case max
}

extension CheckerBoardBuilder {
  private var baseLimits: Int { 5000 }
  private var drawDistance: Int { config.maxDrawDistance }

  public mutating func drawGrid(_ draw: (Path, Color) -> Void) {

    guard offsetX.isFinite && offsetY.isFinite else { return }

    /// Converting “screen extents” into “cell indices”.
    let minCol = bound(.min, for: .horizontal)
    let maxCol = bound(.max, for: .horizontal)
    let minRow = bound(.min, for: .vertical)
    let maxRow = bound(.max, for: .vertical)

    /// Clamp to safety limits
    let clampedMinCol = max(minCol, -baseLimits)
    let clampedMaxCol = min(maxCol, baseLimits)
    let clampedMinRow = max(minRow, -baseLimits)
    let clampedMaxRow = min(maxRow, baseLimits)

    /// The cell coordinates of the vanishing point
    /// This allows drawing cells around the vanishing point,
    /// rather than around the centre of the screen
    let vCol = Int(floor((absVanishingPoint.x - offsetX) / cellSize))
    let vRow = Int(floor((absVanishingPoint.y - offsetY) / cellSize))

    // Center-relative draw distance window
    let distMinCol = vCol - drawDistance
    let distMaxCol = vCol + drawDistance
    let distMinRow = vRow - drawDistance
    let distMaxRow = vRow + drawDistance

    // Intersect viewport/perspective bounds with center-relative distance
    let finalMinCol = max(clampedMinCol, distMinCol)
    let finalMaxCol = min(clampedMaxCol, distMaxCol)
    let finalMinRow = max(clampedMinRow, distMinRow)
    let finalMaxRow = min(clampedMaxRow, distMaxRow)

    // Use these for sequencing
    let orderedRows = sequence(center: vRow, min: finalMinRow, max: finalMaxRow)
    let orderedCols = sequence(center: vCol, min: finalMinCol, max: finalMaxCol)

    if debugEnabled {
      DebugString {
        Labeled("Min Cols", value: minCol)
        Labeled("Max Cols", value: maxCol)
        //      Labeled("Row count", value: orderedRows.count)
        //      Labeled("Col count", value: orderedCols.count)
        //      Labeled("Expansion factor", value: expansionFactor)
        //      Labeled("clampedMinCol", value: clampedMinCol)
        //      Labeled("clampedMaxCol", value: clampedMaxCol)
        Divider()
      }
    }

    self.rows = orderedRows
    self.cols = orderedCols

    rowColumnLoop(draw: draw)

  }

  /// Viewport bounds expressed in cell indices, plus padding
  private func bound(_ boundary: RowColBoundary, for axis: GeometryAxis) -> Int {
    let isMin = boundary.isMin
    let extent = axis.isHorizontal ? width : height
    let offset = axis.isHorizontal ? offsetX : offsetY

    let distanceToBoundary = isMin ? -offset : extent - offset
    let base = distanceToBoundary / cellSize  // in cells

    guard let padCells = expansionPaddingCells else { return 0 }

    guard isMin else {
      /// include extra cells beyond edge, and round outward (up)
      return Int(ceil(base + padCells))
    }
    /// include extra cells beyond edge, and round outward (down)
    return Int(floor(base - padCells))
  }

}
