//
//  SelectionHandler.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 25/2/2026.
//

import CanvasKit
import CoreTools
import SwiftUI

@Observable
public final class SelectionHandler {

  /// This should come in from CanvasKit, and be mapped to canvas/local
  var pointerLocation: CGPoint?
  var zoom: CGFloat = 1
  var pan: CGSize = .zero
  var geometry: GridGeometry?
}

extension SelectionHandler {

  /// Returns the row and column index for a global pointer location
  /// Returns nil if the pointer is outside the grid boundaries
  var pointerGridPosition: GridPosition? {
    guard let geometry, let pointerLocation else { return nil }
    return pointerLocation.gridPosition(geometry: geometry)
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
}
