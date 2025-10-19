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
  //  public func toGridCount(
  //    along axis: Axis,
  //    using unitSize: CGSize,
  //    rounding: GridRounding = .down
  //  ) -> Int? {
  //    let unitLength = axis.length(fromSize: unitSize)
  //    return self.toGridCount(using: unitLength, rounding: rounding)
  //  }

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

  //  public func snappedToGrid(
  //    along axis: Axis,
  //    using unitSize: CGSize,
  //    rounding: GridRounding = .down
  //  ) -> Self {
  //    let unitLength = axis.length(fromSize: unitSize)
  //    return self.snappedToGrid(using: unitLength, rounding: rounding)
  //  }
  //
  /// Returns `self`, but having gone through the `toGridCount`
  /// process, and then `toScreenLength`, resulting in a value
  /// that's still a float, but now 'quantised' to the integer equivalent
  public func snappedToGrid(
    using unitLength: CGFloat,
    rounding: GridRounding = .down
  ) -> Self {
    guard isValidState(with: unitLength),
      let gridCount = self.toGridCount(using: unitLength, rounding: rounding),
      let result = gridCount.toScreenLength(using: unitLength)
    else { return self }

    return Self(result)
  }
}

// MARK: - Int extension
extension Int {

  public func toScreenLength(
    using unitLength: CGFloat,
  ) -> CGFloat? {
//    print("Converting count of `\(self)` to screen length, with unit length `\(unitLength)`")
    guard isValidState(with: unitLength) else { return nil }
    let result = CGFloat(self) * unitLength
//    print("Resulting screen length: \(result)")
    return result
  }
  
  private func isValidState(with unitLength: CGFloat) -> Bool {
//    print("Checking if Int of value `\(self)` is valid for conversion with unit length \(unitLength)")
    let result = self >= 0 && unitLength > 0 && unitLength.isFinite
//    print("State is valid? `\(result)`")
    return result

  }
}

extension CGSize {

  /// The axis is justified here, as we need to specify the edge for `self`
  public func toGridCount(
    along axis: Axis,
    using unitSize: CGSize,
    rounding: GridRounding = .down
  ) -> Int? {
    let lengthOfSelf = axis.length(fromSize: self)
    let unitLength = axis.length(fromSize: unitSize)
    return lengthOfSelf.toGridCount(using: unitLength, rounding: rounding)
  }

  public func toGridSize(
    using unitSize: CGSize,
    rounding: GridRounding = .down
  ) -> GridSize? {
    guard let gridWidth = self.width.toGridCount(using: unitSize.width, rounding: rounding),
      let gridHeight = self.height.toGridCount(using: unitSize.height, rounding: rounding)
    else { return nil }
    return GridSize(width: gridWidth, height: gridHeight, unitSize: unitSize)
  }

  public func toGridCounts(
    using unitSize: CGSize,
    rounding: GridRounding = .down
  ) -> GridSizeCounts? {
    let size = self.toGridSize(using: unitSize, rounding: rounding)
    return size?.gridSizeCounts
  }

}
