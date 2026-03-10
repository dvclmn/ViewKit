//
//  Env+Grid.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 2/3/2026.
//

import SwiftUI

extension EnvironmentValues {

  @Entry public var gridDimensions: GridDimensions?
  @Entry public var gridFont: GridFont?
  @Entry public var isShowingCellNumbers: Bool = false
  @Entry public var gridLineColour: Color = .cyan.opacity(0.17)
  @Entry public var gridLineWidth: CGFloat = 1.0
  
  @Entry public var isCellSelectionEnabled: Bool = true

  public var pointerGridPosition: GridPosition? {
    guard let gridGeometry else {
      printMissing("gridGeometry", for: "pointerGridPosition")
      return nil
    }

    guard let pointerLocation else {
      printMissing("pointerLocation", for: "pointerGridPosition")
      return nil
    }

    return pointerLocation.gridPosition(geometry: gridGeometry)
  }

  /// Note: This hard-codes / assumes `unitSize` (not `asciiUnitSize` nor
  /// `activeUnitSize`). Derives anchor from `canvasAnchor` Env value.
  public var gridGeometry: GridGeometry? {

    guard let viewportRect else {
      //      printMissing("viewportRect", for: "gridGeometry")
      return nil
    }

    guard let gridDimensions else {
      //      printMissing("gridDimensions", for: "gridGeometry")
      return nil
    }

    guard let unitSize else {
      //      printMissing("unitSize", for: "gridGeometry")
      return nil
    }

    return GridGeometry(
      viewportRect: viewportRect,
      dimensions: gridDimensions,
      unitSize: unitSize,
      anchor: canvasAnchor
    )
  }
}
