//
//  SelectionHandler.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 25/2/2026.
//

import CoreTools
import CanvasKit
import SwiftUI

@Observable
final class SelectionHandler {
  
  /// This should come in from CanvasKit, and be mapped to canvas/local
  var pointerLocation: CGPoint?
  var zoom: CGFloat = 1
  var pan: CGSize = .zero
  var geometry: GridGeometry?
}

extension SelectionHandler {
//  private var viewportContext: ViewportContext? {
//    guard let geometry else { return nil }
//    return geometry.viewportContext(zoom: zoom, pan: pan)
//  }
//
//  private var pointerHoverMapper: PointerHoverHandler? {
//    guard let context = viewportContext else { return nil }
//    return PointerHoverHandler(context: context)
//  }

  /// Aka Canvas space
//  var pointerLocalSpace: CGPoint? {
//    guard
//      let pointerLocation,
//      let mapped = pointerHoverMapper?.map(screenPoint: pointerLocation)
//    else { return nil }
//
//    return mapped.canvas
//  }

//  #if DEBUG
//  var pointerRoundTripError: CGFloat? {
//    guard
//      let pointerLocation,
//      let mapper = pointerHoverMapper
//    else { return nil }
//    return mapper.roundTripError(screenPoint: pointerLocation)
//  }
//  #endif

  /// Returns the row and column index for a global pointer location
  /// Returns nil if the pointer is outside the grid boundaries
  var pointerGridPosition: GridPosition? {
    guard
      let geometry,
      let pointerLocation
//      let mapped = pointerHoverMapper?.mapIfInside(screenPoint: pointerLocation)
    else { return nil }

    let point = Point<CanvasSpace>(fromPoint: pointerLocation)
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

//  var isPointerInCell: Bool {
//    guard let local = pointerLocalSpace else { return false }
//    return selectionRect?.contains(local) ?? false
//  }
}
