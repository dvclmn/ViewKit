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
  var geometry: GridGeometry?
}

extension SelectionHandler {

  private var viewportRect: CGRect? {
    geometry?.viewportRect
  }

  private var dimensions: GridDimensions? {
    geometry?.dimensions
  }

  private var viewportContext: ViewportContext? {
    guard let geometry else { return nil }
    return geometry.viewportContext(zoom: zoom, pan: pan)
  }

  /// Aka Canvas space
  var pointerLocalSpace: CGPoint? {
    guard let pointerLocation, let context = viewportContext else { return nil }
    let canvasPoint = context.toCanvas(
      screenPoint: Point<ScreenSpace>(fromPoint: pointerLocation)
    )
    return CGPoint(x: canvasPoint.x, y: canvasPoint.y)
  }

  #if DEBUG
  var pointerRoundTripError: CGFloat? {
    guard let pointerLocation, let context = viewportContext else { return nil }
    let local = context.toCanvas(screenPoint: Point<ScreenSpace>(fromPoint: pointerLocation))
    let roundTrip = context.toGlobal(point: CGPoint(x: local.x, y: local.y))
    return hypot(roundTrip.x - pointerLocation.x, roundTrip.y - pointerLocation.y)
  }
  #endif

  /// Returns the row and column index for a global pointer location
  /// Returns nil if the pointer is outside the grid boundaries
  var pointerGridPosition: GridPosition? {
    guard let geometry else { return nil }

    /// 1. Convert Global Screen Space -> Local Canvas Space
    guard let local = pointerLocalSpace else { return nil }

    /// 2. Perform Boundary Check
    /// Ensure the pointer isn't in the "empty space" around the canvas
    let canvasSize = geometry.canvasSize.cgSize
    guard local.x >= 0, local.x < canvasSize.width,
      local.y >= 0, local.y < canvasSize.height
    else {
      return nil
    }

    /// 3. Convert Local Coordinate -> Grid Indices
    let point = Point<CanvasSpace>(fromPoint: local)
    return geometry.projection.gridPositionIfValid(from: point)
  }

  var selectionRect: CGRect? {
    guard let position = pointerGridPosition else { return nil }
    guard let cellSize = geometry?.projection.unitSize else { return nil }

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
