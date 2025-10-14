//
//  Grid+Extensions.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 14/10/2025.
//

import SwiftUI

// MARK: - Float extension
extension BinaryFloatingPoint {

  
  /// Converts a float (screen) value, to an integer (grid) value,
  /// based on a unit reference point (`unitSize`).
  ///
  /// Because this method accepts
  /// a unit of type `CGSize`,  an `axis` is provided to
  /// specify which edge to use as the unit length.
  /// - Parameters:
  ///   - axis: The edge to use for the unit length, from `unitSize`
  ///   - unitSize: The size that defines a new reference point, where width == 1 unit wide, and height == 1 unit high
  ///   - rounding: Whether to round up or down, when converting floats to integers
  /// - Returns: An integer that represents the number of 'units' that can fit along the length of `self`
  public func toGridCount(
    along axis: Axis,
    using unitSize: CGSize,
    rounding: GridRounding = .down
  ) -> Int? {
    let unitLength = axis.length(fromSize: unitSize)
    return self.toGridCount(using: unitLength, rounding: rounding)
  }

  public func toGridCount(
    using unitLength: CGFloat,
    rounding: GridRounding = .down
  ) -> Int? {
    guard isValidState(with: unitLength) else { return nil }
    let resultRounded = (CGFloat(self) / unitLength).rounded(rounding.value)
    return Int(resultRounded)
  }

  private func isValidState(with unitLength: CGFloat) -> Bool {
    self > 0 && unitLength > 0 && unitLength.isFinite
  }
}

// MARK: - Int extension
extension Int {

  public func toScreenLength(
    along axis: Axis,
    using unitSize: CGSize,
  ) -> CGFloat? {
    let unitLength = axis.length(fromSize: unitSize)
    return toScreenLength(using: unitLength)
  }

  public func toScreenLength(
    using unitLength: CGFloat,
  ) -> CGFloat? {
    guard isValidState(with: unitLength) else { return nil }
    return CGFloat(self) * unitLength
  }
  private func isValidState(with unitLength: CGFloat) -> Bool {
    self >= 0 && unitLength > 0 && unitLength.isFinite
  }
}

extension CGSize {

  public func toGridCount(
    along axis: Axis,
    using unitSize: CGSize,
    rounding: GridRounding = .down
  ) -> Int? {
    let lengthOfSelf = axis.length(fromSize: self)
    return lengthOfSelf.toGridCount(
      along: axis,
      using: unitSize,
      rounding: rounding
    )
  }

  public func toGridCount(
    along axis: Axis,
    using unitLength: CGFloat,
    rounding: GridRounding = .down
  ) -> Int? {
    let lengthOfSelf = axis.length(fromSize: self)
    return lengthOfSelf.toGridCount(using: unitLength, rounding: rounding)
  }
  
  public func toGridSize(
    using unitSize: CGSize,
    rounding: GridRounding = .down
  ) -> GridSize? {
    guard let gridWidth = self.width.toGridCount(along: .horizontal, using: unitSize, rounding: rounding),
    let gridHeight = self.height.toGridCount(along: .vertical, using: unitSize, rounding: rounding)
            else { return nil }
    return GridSize(width: gridWidth, height: gridHeight, unitSize: unitSize)
  }
  
  public func toGridCounts(
    using unitSize: CGSize,
//    using unitLength: CGFloat,
    rounding: GridRounding = .down
  ) -> GridSizeCounts? {
//    let lengthOfSelf = axis.length(fromSize: self)
    
    let size = self.toGridSize(using: unitSize, rounding: rounding)
//    let size = lengthOfSelf.toGridCount(using: unitLength, rounding: rounding)
    return size?.gridSizeCounts
  }
  
  

}
