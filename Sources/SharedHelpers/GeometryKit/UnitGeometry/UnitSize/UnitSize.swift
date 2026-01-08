//
//  UnitSize.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 14/10/2025.
//

import Foundation

/// Equivalent to `CGSize`
public struct UnitSize: Hashable, Codable, Sendable {

  /// Columns == Width is the more common convention.
  ///
  public var width: UnitLength

  /// Rows == Height
  public var height: UnitLength

  public init(
    width: UnitLength,
    height: UnitLength,
  ) {
    self.width = width
    self.height = height
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
      width: UnitLength(magnitude: width, unitLength: unitSize.width),
      height: UnitLength(magnitude: height, unitLength: unitSize.height),
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

  public init(
    dimensions: GridDimensions,
    unitSize: CGSize
  ) {
    self.width = UnitLength(
      magnitude: dimensions.width,
      unitLength: unitSize.width
    )
    self.height = UnitLength(
      magnitude: dimensions.height,
      unitLength: unitSize.height
    )
  }
  
  public init(magnitudeA: Int, magnitudeB: Int, other: UnitSize) {
    self.init(
      width: UnitLength(magnitude: magnitudeA, unitLength: other.width.unitLength),
      height: UnitLength(magnitude: magnitudeB, unitLength: other.height.unitLength)
    )
  }

}
