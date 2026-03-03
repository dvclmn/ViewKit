//
//  Model+GridResize.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 8/8/2025.
//

import SwiftUI

@available(
  *,
  unavailable,
  message: "GridResizeHelper is being migrated to the new GridDimensions/GridProjection model."
)
public struct GridResizeHelper {
  public init(
    oldDimensions: GridDimensions,
    newDimensions: GridDimensions,
    boundaryPoint: GridBoundaryPoint,
    anchorPoint: UnitPoint
  ) {}
}
