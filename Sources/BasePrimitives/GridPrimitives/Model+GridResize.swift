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

// MARK: - Grid Geometry
//public struct GridGeometry: Sendable, Equatable {
//  public let unitSize: CGSize // Aka Cell size
//  public let dimensions: GridDimensions
//
//  public static let zero = GridGeometry(
//    cellSize: .zero,
//    dimensions: .minSize
//  )
//
//  public init(
//    cellSize: CGSize,
//    dimensions: GridDimensions
//  ) {
//    self.unitSize = cellSize
//    self.dimensions = dimensions
//  }
//
//  public var canvasSize: CGSize {
//    dimensions.screenSize(using: unitSize)
//  }
//}
