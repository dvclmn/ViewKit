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

  public func toScreenLength(
    along axis: Axis2D,
    mapping: AxisMapping = .default,
    //    convention: AxisConvention = .default,
    using unitSize: CGSize?,
  ) -> CGFloat? {
    guard let unitSize else { return nil }
    let length = unitSize.value(along: axis, mapping: mapping)
    return toScreenLength(using: length)
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
    along axis: Axis2D,
    using unitSize: CGSize,
    mapping: AxisMapping = .default,
    rounding: GridRounding = .down
  ) -> Int? {

    /// Ensures the same convention is used for extracting both length values
    let lengthOfSelf = self.value(along: axis, mapping: mapping)
    let unitLength = unitSize.value(along: axis, mapping: mapping)
    return lengthOfSelf.toGridCount(using: unitLength, rounding: rounding)
  }

  public func toUnitSize(
    using unitSize: CGSize,
    rounding: GridRounding = .down
  ) -> UnitSize? {
    UnitSize(fromSize: self, unitSize: unitSize, rounding: rounding)
  }
}

extension Optional where Wrapped == CGSize {
  public func gridLength(
    _ count: Int,
    along axis: Axis2D,
  ) -> CGFloat? {
    return count.toScreenLength(along: axis, using: self)
  }
}
