//
//  Model+GridResize.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 8/8/2025.
//

import SwiftUI

public struct GridResizeHelper {
  let oldSize: UnitSize
  let newSize: CGSize
  let boundaryPoint: GridBoundaryPoint
  let anchorPoint: UnitPoint

  public init(
    oldSize: UnitSize,
    newSize: CGSize,
    boundaryPoint: GridBoundaryPoint,
    anchorPoint: UnitPoint
  ) {
    self.oldSize = oldSize
    self.newSize = newSize
    self.boundaryPoint = boundaryPoint
    self.anchorPoint = anchorPoint
  }
}
extension GridResizeHelper {

//  var unitSize: CGSize { oldSize }

  
  public var resizeDelta: GridDimensions {
fatalError("WIP, needs to be completed after changes to UnitSize/GridDimensions")
//    let oldDimensions = oldSize.dimensions
//    let newDimensions = GridDimensions(<#T##width: Int##Int#>, <#T##height: Int##Int#>)
//    let newDimensions = GridDimensions(
//      size: newSize,
//      cellSize: cellSize,
//    )
//    assert(
//      boundaryPoint
//        .isValidSizeDelta(
//          from: oldSize,
//          to: newDimensions
//        ),
//      "Invalid size delta for boundary point"
//    )
//    let delta = GridDelta(old: oldDimensions, new: newDimensions)
//
//    return delta
  }

  public func resize<T: GridShaped>(_ artwork: inout T) {
//  public func resize(_ artwork: inout any GridShaped) {
    artwork.resize(by: resizeDelta, at: affectedEdges)
  }

  public var affectedEdges: GridEdge.Set { boundaryPoint.edgesToResize(anchor: anchorPoint) }
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
