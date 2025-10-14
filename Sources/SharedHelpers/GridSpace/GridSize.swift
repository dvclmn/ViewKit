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
  public var width: GridLength

  /// Rows == Height
  public var height: GridLength

  public init(
    width: GridLength,
    height: GridLength,
  ) {
    self.width = width
    self.height = height
  }
}

extension GridSize {
  public var screenSize: CGSize {
    CGSize(width: width.screenLength, height: height.screenLength)
  }

  public func adjustCounts(
    transform: (Int, Int) -> (width: Int, height: Int)
  ) -> GridSize? {
    let transformed = transform(width.count, height.count)
    return GridSize(
      width: transformed.width,
      height: transformed.height,
      unitSize: unitSize
    )
  }

  private var unitSize: CGSize {
    return CGSize(
      width: width.unit,
      height: height.unit
    )
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
      width: GridLength(count: width, unit: unitSize.width),
      height: GridLength(count: height, unit: unitSize.height),
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
