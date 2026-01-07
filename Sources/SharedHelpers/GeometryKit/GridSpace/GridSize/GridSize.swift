//
//  UnitSize.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 14/10/2025.
//

import Foundation

/// Equivalent to `CGSize`
public struct UnitSize: Hashable, Codable {

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
extension UnitSize {

  public init(
    width: Int,
    height: Int,
    unitSize: CGSize
  ) {
    self.init(
      columns: GridLength(count: width, unitLength: unitSize.width),
      rows: GridLength(count: height, unitLength: unitSize.height),
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
