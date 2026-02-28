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
  var canvasSize: CGSize?
  var cellSize: CGSize?
  var geometry: GridGeometry?
  //  var viewportRect: CGRect?
  //  var gridDimensions: GridDimensions?
}

extension SelectionHandler {

  private var viewportRect: CGRect? {
    geometry?.viewportRect
  }

  private var dimensions: GridDimensions? {
    geometry?.subjectSize.dimensions
  }

  private var coordinateTransform: CoordinateSpaceContext? {
    guard let geometry, let cellSize else { return nil }
    return .init(
      zoom: zoom,
      pan: pan,
      panSpace: .global,
      geometry: geometry,
      unitSize: cellSize
    )
  }
  //  private var coordinateTransform: CoordinateSpaceContext<GridCanvasGeometry>? {
  //    guard let viewportRect, let canvasSize else { return nil }
  //    return CoordinateSpaceContext(
  //      viewAnchor: .anchoredToCentre,
  //      zoom: zoom,
  //      pan: pan,
  //      viewportRect: viewportRect,
  //      canvasSize: canvasSize,
  //      panSpace: .global
  //    )
  //  }

  /// Aka Canvas space
  var pointerLocalSpace: CGPoint? {
    guard let pointerLocation, let transform = coordinateTransform else { return nil }

    #if DEBUG
    transform.assertRoundTrip(global: pointerLocation)
    #endif

    return transform.toLocal(point: pointerLocation)
  }

  #if DEBUG
  var pointerRoundTripError: CGFloat? {
    guard let pointerLocation, let transform = coordinateTransform else { return nil }
    return transform.roundTripError(global: pointerLocation)
  }
  #endif

  private func unitSize(_ columns: Int, _ rows: Int) -> UnitSize? {
    guard let cellSize else { return nil }
    return UnitSize(width: columns, height: rows, unitSize: cellSize)
  }

  /// Returns the row and column index for a global pointer location
  /// Returns nil if the pointer is outside the grid boundaries
  var pointerGridPosition: GridPosition? {
    //    guard let dimensions else { return nil }
    //    let unitSize = unitSize(dimensions.columns, dimensions.rows)
    //    guard let gridScreenSize = unitSize?.screenSize else { return nil }
    //    guard let cellSize else { return nil }

    guard let cellSize,
      let size = geometry?.subjectSize.toCGSize
    else { return nil }

    /// 1. Convert Global Screen Space -> Local Canvas Space
    guard let local = pointerLocalSpace else { return nil }

    /// 2. Perform Boundary Check
    /// Ensure the pointer isn't in the "empty space" around the canvas
    guard local.x >= 0, local.x < size.width,
      local.y >= 0, local.y < size.height
    else {
      return nil
    }

    /// 3. Convert Local Coordinate -> Grid Indices
    let col = Int(local.x / cellSize.width)
    let row = Int(local.y / cellSize.height)

    return GridPosition(row, col)
  }

  var selectionRect: CGRect? {
    guard let position = pointerGridPosition else { return nil }
    guard let cellSize else { return nil }

    let originX = CGFloat(position.column) * cellSize.width
    let originY = CGFloat(position.row) * cellSize.height
    return CGRect(
      x: originX, y: originY,
      width: cellSize.width,
      height: cellSize.height
    )
  }

  var isPointerInCell: Bool {
    guard let local = pointerLocalSpace else { return false }
    return selectionRect?.contains(local) ?? false
  }
}
