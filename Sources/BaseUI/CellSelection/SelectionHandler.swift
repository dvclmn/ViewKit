//
//  SelectionHandler.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 25/2/2026.
//

import CoreTools
import SwiftUI

@Observable
final class SelectionHandler {
  var pointerLocation: CGPoint?
  var zoom: CGFloat = 1
  var pan: CGSize = .zero
  var viewportRect: CGRect?
  var canvasSize: CGSize?
  var cellSize: CGSize?
}

extension SelectionHandler {

  /// Aka Canvas space
  var pointerLocalSpace: CGPoint? {
    guard let pointerLocation,
      let viewportRect,
      let canvasSize
    else { return nil }
    let transform = CoordinateSpaceTransform(
      viewAnchor: .anchoredToCentre,
      zoom: zoom,
      pan: pan,
      viewportRect: viewportRect,
      canvasSize: canvasSize
    )

    return transform.toLocal(point: pointerLocation)
    //    return CoordinateSpaceTransform.toLocal(
    //      point: pointerLocation,
    //      zoom: zoom,
    //      pan: pan
    //    )
  }

  private func unitSize(_ columns: Int, _ rows: Int) -> UnitSize? {
    guard let cellSize else { return nil }
    return UnitSize(width: columns, height: rows, unitSize: cellSize)
  }

  /// Returns the row and column index for a global pointer location
  /// Returns nil if the pointer is outside the grid boundaries
  public func cellIndex(
    at globalPoint: CGPoint,
    gridDimensions: GridDimensions
      //    grid: GridMetadata

  ) -> (row: Int, col: Int)? {

    let unitSize = unitSize(gridDimensions.columns, gridDimensions.rows)
    guard let gridScreenSize = unitSize?.screenSize else { return nil }
    guard let cellSize else { return nil }
    /// 1. Convert Global Screen Space -> Local Canvas Space
    guard let local = pointerLocalSpace else { return nil }
    //    let local = toLocal(point: globalPoint)

    /// 2. Perform Boundary Check
    /// Ensure the pointer isn't in the "empty space" around the canvas
    guard local.x >= 0, local.x < gridScreenSize.width,
      local.y >= 0, local.y < gridScreenSize.height
    else {
      return nil
    }

    // 3. Convert Local Coordinate -> Grid Indices
    let col = Int(local.x / cellSize.width)
    let row = Int(local.y / cellSize.height)

    return (row, col)
  }
}
