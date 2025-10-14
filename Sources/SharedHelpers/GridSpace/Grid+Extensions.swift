//
//  Grid+Extensions.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 14/10/2025.
//

import SwiftUI

// MARK: - Float extension
extension BinaryFloatingPoint {

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

}
