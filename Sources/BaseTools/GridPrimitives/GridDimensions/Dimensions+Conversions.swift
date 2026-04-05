//
//  Dimensions+Conversions.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 20/3/2026.
//

import Foundation

extension String {
  public var gridDimensions: GridDimensions {
    let width: Int = longestLineLength
    let height: Int = lines(omissionStrategy: .doNotOmit).count
    return GridDimensions(width: width, height: height)
  }
}

extension GridDimensions {

  public func toScreenSize(
    using unitSize: CGSize,
    mapping: AxisMapping = .default,
  ) -> CGSize {
    GridScreenConversion.screenSize(
      for: self,
      unitSize: unitSize,
      mapping: mapping,
    )
  }

  public func toScreenSizeIfPossible(
    using unitSize: CGSize?,
    mapping: AxisMapping = .default,
  ) -> CGSize? {
    guard let unitSize else { return nil }
    guard
      let width = value(along: .horizontal, mapping: mapping)
        .toScreenLengthIfPossible(along: .horizontal, mapping: mapping, using: unitSize),
      let height = value(along: .vertical, mapping: mapping)
        .toScreenLengthIfPossible(along: .vertical, mapping: mapping, using: unitSize)
    else { return nil }
    return CGSize(width: width, height: height)
  }

  //  public func toScreenSize(using unitSize: CGSize) -> CGSize {
  ////    assert(width >= 0 && height >= 0, "Grid dimensions must be non-negative")
  ////    assert(unitSize.width > 0 && unitSize.height > 0 && unitSize.width.isFinite && unitSize.height.isFinite,
  ////           "Unit size must be positive and finite")
  //    let w = width.toScreenLength(using: <#T##CGFloat#>)
  //    return CGSize(
  //      width: CGFloat(width) * unitSize.width,
  //      height: CGFloat(height) * unitSize.height
  //    )
  //  }

  //  public func toScreenSize(using unitSize: CGSize) -> CGSize? {
  //    guard
  //      let width = width.toScreenLength(using: unitSize.width),
  //      let height = height.toScreenLength(using: unitSize.height)
  //    else { return nil }
  //
  //    return CGSize(width: width, height: height)
  //  }
}

extension CGSize {

  public func toGridDimensions(
    using unitSize: CGSize,
    rounding: GridRounding = .down,
  ) -> GridDimensions? {
    guard
      let width = width.toGridCount(using: unitSize.width, rounding: rounding),
      let height = height.toGridCount(using: unitSize.height, rounding: rounding),
      width > 0,
      height > 0
    else {
      printMissing("width or height", for: "toGridDimensions(using:rounding:)")
      return nil
    }

    return GridDimensions(width: width, height: height)
  }

  public func snappedToGrid(
    using unitSize: CGSize,
    rounding: GridRounding = .down,
  ) -> CGSize? {
    guard let dimensions = toGridDimensions(using: unitSize, rounding: rounding) else {
      return nil
    }
    return dimensions.toScreenSize(using: unitSize)
  }

}
