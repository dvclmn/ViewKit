//
//  Unit+CGSize.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 27/2/2026.
//

import Foundation

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
