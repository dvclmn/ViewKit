//
//  Unit+Extensions.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 27/2/2026.
//

import Foundation

extension Int {

  public func toScreenLength(using unitLength: CGFloat) -> CGFloat {
    assertSafeToConvert(self, using: unitLength)
    return CGFloat(self) * unitLength
  }

  public func toScreenLengthIfPossible(
    using unitLength: CGFloat?
  ) -> CGFloat? {
    guard let unitLength,
      unitLength.isFiniteAndGreaterThanZero,
      self >= 0
    else { return nil }
    return CGFloat(self) * unitLength
  }
  
  public func toScreenLength(
    along axis: GridAxis,
    mapping: AxisMapping = .default,
    using unitSize: CGSize
  ) -> CGFloat {
//    guard let unitSize else { return nil }
    let length = unitSize.value(along: axis, mapping: mapping)
    return toScreenLength(using: length)
  }

  
  public func toScreenLengthIfPossible(
    along axis: GridAxis,
    mapping: AxisMapping = .default,
    using unitSize: CGSize?
  ) -> CGFloat? {
    guard let unitSize else { return nil }
    let length = unitSize.value(along: axis, mapping: mapping)
    return toScreenLength(using: length)
  }

  //  public func toScreenLength(
  //    along axis: GridAxis,
  //    mapping: AxisMapping = .default,
  //    using unitSize: CGSize?,
  //  ) -> CGFloat? {
  //    guard let unitSize else { return nil }
  //    let length = unitSize.value(along: axis, mapping: mapping)
  //    return toScreenLength(using: length)
  //  }

}
