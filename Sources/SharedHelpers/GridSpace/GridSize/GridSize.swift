//
//  GridSize.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 14/10/2025.
//

import Foundation

/// Equivalent to `CGSize`
public struct GridSize: Hashable, Codable {

  /// Columns == Width
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
    fromSize size: CGSize,
    unitSize: CGSize,
    rounding: GridRounding = .down
  ) {

    let width = size.toGridCount(
      along: .horizontal,
      using: unitSize,
      rounding: rounding
    )

    let height = size.toGridCount(
      along: .vertical,
      using: unitSize,
      rounding: rounding
    )
    guard let width, let height else { return nil }

    self.init(width: width, height: height, unitSize: unitSize)
  }

}
