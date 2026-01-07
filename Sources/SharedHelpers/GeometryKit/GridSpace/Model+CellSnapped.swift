//
//  Model+CellSnapped.swift
//  DrawString
//
//  Created by Dave Coleman on 7/8/2025.
//

import Foundation

/// I thiiink these are all covered by GridSize/GridLength APIs
//extension CGSize {
//
//  /// Converts `self` to
//  public func quantised(
//    using cellSize: CGSize,
//    strategy: SnapStrategy
//  ) -> CGSize {
//    let snappedCounts = cellSnappedSize(cellSize: cellSize, strategy: strategy)
//    return cellSize * snappedCounts
//  }
//
//  public func cellCount(
//    alongAxis axis: Axis2D,
//    cellSize: CGSize,
//    strategy: SnapStrategy,
//    convention: AxisConvention = .default
//  ) -> Int {
//    let dimensions = cellSnappedSize(
//      cellSize: cellSize,
//      strategy: strategy
//    )
//    let length = dimensions.value(for: axis, convention: convention)
//    return length.gridLength
//    //    let conventionalAxis =
//    //    return switch axis {
//    //      case .column: dimensions.width
//    //      case .row: dimensions.height
//    //    }
//  }
//
//  public func cellSnappedSize(
//    cellSize: CGSize,
//    strategy: SnapStrategy,
//    convention: AxisConvention = .default
//  ) -> GridSize {
//    //  ) -> GridDimensions {
//
//    //    let sizeRaw = self.divideBoth(by: cellSize, convention: convention)
//    ////    let sizeRaw = self.adjustBoth(convention: convention) { h, v in
//    ////      return (h / cellSize.width, v / cellSize.length)
//    ////    }
//    //
//    ////    let colsRaw = sizeRaw.length(along: <#T##Axis2D#>, convention: convention)
//    ////    let colsRaw = sizeRaw.width / cellSize.width
//    ////    let rowsRaw = sizeRaw.height / cellSize.height
//    //
//    //    let width: Int = strategy.snapped(sizeRaw.width)
//    //    let height: Int = strategy.snapped(sizeRaw.height)
//
//    //    switch strategy {
//    //      case .floor:
//    //        cols = Int(floor(colsRaw))
//    //        rows = Int(floor(rowsRaw))
//    //
//    //      case .ceil:
//    //        cols = Int(ceil(colsRaw))
//    //        rows = Int(ceil(rowsRaw))
//    //
//    //      case .round:
//    //        cols = Int(colsRaw.rounded())
//    //        rows = Int(rowsRaw.rounded())
//    //    }
//
//    return GridSize(size: self, cellSize: cellSize, strategy: strategy, convention: convention)
//    //    return GridSize(width: width, height: height, unitSize: cellSize)
//    //    return GridDimensions(width: cols, height: rows)
//  }
//
//}
