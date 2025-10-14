//
//  GridSize.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 14/10/2025.
//

import Foundation

/// Equivalent to `CGSize`
public struct GridSize: Hashable, Codable {
  public var rows: GridLength
  public var columns: GridLength

  public init(
    rows: GridLength,
    columns: GridLength,
  ) {
    self.rows = rows
    self.columns = columns
  }

}

extension GridSize {
  public var screenSize: CGSize {
    CGSize(width: columns.screenLength, height: rows.screenLength)
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
      rows: GridLength(count: height, unit: unitSize.width),
      columns: GridLength(count: width, unit: unitSize.height),
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
    //    self.init(
    //      columns: GridLength(count: width, unit: unit),
    //      rows: GridLength(count: height, unit: unit)
    //    )
  }
}
