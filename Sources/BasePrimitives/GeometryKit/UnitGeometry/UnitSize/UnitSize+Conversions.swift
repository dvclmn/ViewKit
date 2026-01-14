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
    let resultRounded = (CGFloat(self) / unitLength).rounded(using: rounding)
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
    along axis: GridAxis,
    mapping: AxisMapping = .default,
    //    convention: AxisConvention = .default,
    using unitSize: CGSize?,
  ) -> CGFloat? {
    guard let unitSize else { return nil }
    let length = unitSize.value(along: axis, mapping: mapping)
    return toScreenLength(using: length)
  }

  //  public func toScreenSize(
  //    //    along axis: GridAxis,
  //    //    mapping: AxisMapping = .default,
  //    //    convention: AxisConvention = .default,
  //    using unitSize: CGSize?,
  //  ) -> CGSize? {
  //
  //    guard let unitSize else { return nil }
  //
  //    let width = unitSize.width
  //    let height = unitSize.height
  //    guard isValidState(with: width),
  //      isValidState(with: height)
  //    else { return nil }
  //
  //    toScreenLength(using: <#T##CGFloat#>)
  //    //    let length = unitSize.value(along: axis, mapping: mapping)
  //    //    return toScreenLength(using: length)
  //  }

  private func isValidState(with unitLength: CGFloat) -> Bool {
    //    print("Checking if Int of value `\(self)` is valid for conversion with unit length \(unitLength)")
    let result = self >= 0 && unitLength > 0 && unitLength.isFinite
    //    print("State is valid? `\(result)`")
    return result

  }
}

extension CGPoint {

  /// Returns the relative UnitPoint (not snapped) within a given size.
  ///
  /// Usage:
  /// ```
  /// let point = CGPoint(x: 10, y: 5)
  /// let frameSize = CGSize(width: 100, height: 100)
  ///
  /// let closestAnchor = point.nearestAnchor(in: frameSize)
  /// print(closestAnchor)  // Might print `.topLeading` if point is near (0,0)
  /// ```
  public func toUnitPoint(
    in size: CGSize,
    rounding: GridRounding = .none,
    fallback: UnitPoint = .center
  ) -> UnitPoint {

    guard size.isGreaterThanOrEqualToZero else { return fallback }

    let rawX = x / size.width
    let rawY = y / size.height

    let valX = rounding.roundedIfNeeded(rawX)
    let valY = rounding.roundedIfNeeded(rawY)
    //    if let rounding {
    //      let valX = x.rounded(rounding.rule)
    //    }

    return UnitPoint(x: valX, y: valY)
  }
  //
  //  public func toUnitPoint(in unitSize: CGSize) -> UnitPoint {
  //
  //  }
  //  public init(
  //    point: CGPoint,
  //    cellSize: CGSize
  //  ) {
  //    /// `floor()` here maps a continuous coordinate to the
  //    /// nearest lower integer, effectively identifying which grid cell
  //    /// the point belongs to.
  //    let col = Int(floor(point.x / cellSize.width))
  //    let row = Int(floor(point.y / cellSize.height))
  //
  //    self.init(row: row, column: col)
  //  }
}

extension CGSize {

  /// The axis is justified here, as we need to specify the edge for `self`
  public func toGridCount(
    along axis: GridAxis,
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
  
  public func snapped(
    using unitSize: CGSize,
    rounding: GridRounding = .down
  ) -> CGSize? {
    toUnitSize(using: unitSize, rounding: rounding)?.screenSize
  }
}

extension Optional where Wrapped == CGSize {
  public func gridLength(
    _ count: Int,
    along axis: GridAxis,
  ) -> CGFloat? {
    return count.toScreenLength(along: axis, using: self)
  }
}
