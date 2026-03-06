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

  public var pointerGridPosition: GridPosition? {
    guard let gridGeometry else {
      print(missingValue("gridGeometry", for: "pointerGridPosition"))
      return nil
    }

    guard let pointerLocation else {
      print(missingValue("pointerLocation", for: "pointerGridPosition"))
      return nil
    }

    return pointerLocation.gridPosition(geometry: gridGeometry)
    //    guard let geometry, let pointerLocation else { return nil }
    //    return pointerLocation.gridPosition(geometry: geometry)
  }

  /// Note: This hard-codes / assumes `unitSize` (not `asciiUnitSize` nor
  /// `activeUnitSize`). Derives anchor from `canvasAnchor` Env value.
  public var gridGeometry: GridGeometry? {

    guard let viewportRect else {
      print(missingValue("viewportRect", for: "gridGeometry"))
      return nil
    }

    guard let gridDimensions else {
      print(missingValue("gridDimensions", for: "gridGeometry"))
      return nil
    }

    guard let unitSize else {
      print(missingValue("unitSize", for: "gridGeometry"))
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

private func missingValue(_ key: String, for consumer: String) -> String {
  "EnvironmentValue `\(key)` missing, needed by \(consumer)"
  //  "\(file):\(line) \(function): EnvironmentValue `\(key)` missing, needed by `gridGeometry`"
}
