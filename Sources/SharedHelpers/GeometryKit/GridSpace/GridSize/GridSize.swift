//
//  GridSize.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 14/10/2025.
//

import Foundation

/// Equivalent to `CGSize`
public struct GridSize: Hashable, Codable {

  /// Columns == Width is the more common convention.
  ///
  public var columns: GridLength

  /// Rows == Height
  public var rows: GridLength

  public init(
    columns: GridLength,
    rows: GridLength,
  ) {
    self.columns = columns
    self.rows = rows
  }
}

// MARK: - Initialisers
extension GridSize {

  //  public init(
  //    size: CGSize,
  //    cellSize: CGSize,
  //    strategy: SnapStrategy = .round,
  //    convention: AxisConvention = .default
  //  ) {
  //
  //    let sizeRaw = size.divideBoth(by: cellSize, convention: convention)
  //    //    let sizeRaw = self.adjustBoth(convention: convention) { h, v in
  //    //      return (h / cellSize.width, v / cellSize.length)
  //    //    }
  //
  //    //    let colsRaw = sizeRaw.length(along: , convention: convention)
  //    //    let colsRaw = sizeRaw.width / cellSize.width
  //    //    let rowsRaw = sizeRaw.height / cellSize.height
  //
  //    let width: Int = strategy.snapped(sizeRaw.width)
  //    let height: Int = strategy.snapped(sizeRaw.height)
  //
  //    self.init(width: width, height: height, unitSize: cellSize)
  ////    let dimensions = size.cellSnappedSize(
  ////      cellSize: cellSize,
  ////      strategy: strategy
  ////    )
  ////
  ////    self.init(width: <#T##Int#>, height: <#T##Int#>, unitSize: <#T##CGSize#>)
  //
  ////    self.init(width: <#T##Int#>, height: <#T##Int#>, unitSize: <#T##CGSize#>)
  ////    self.init(width: dimensions.width, height: dimensions.height)
  //  }

  public init(
    width: Int,
    height: Int,
    unitSize: CGSize
  ) {
    self.init(
      columns: GridLength(count: width, unit: unitSize.width),
      rows: GridLength(count: height, unit: unitSize.height),
    )
  }

  public init?(
    fromSize size: CGSize?,
    unitSize: CGSize?,
    rounding: GridRounding = .down,
  ) {

    /// Note: no need for `GridAxisConvention` here, as the input `size`
    /// and the `uniSize`'s axes are being operated on consistently, not
    /// being mixed around etc.

    guard let size,
      let unitSize,
      let gridWidth = size.width.toGridCount(
        using: unitSize.width,
        rounding: rounding
      ),
      let gridHeight = size.height.toGridCount(
        using: unitSize.height,
        rounding: rounding
      )
    else { return nil }

    self.init(width: gridWidth, height: gridHeight, unitSize: unitSize)
  }

}
