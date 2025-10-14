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
//    let unitLength = axis.length(fromSize: unitSize)
//    guard isValidState(with: unitLength) else { return nil }
//    let resultRounded = (CGFloat(self) / unitLength).rounded(rounding.value)
//    return Int(resultRounded)
  }

  public func toGridCount(
    using unitLength: CGSize,
    rounding: GridRounding = .down
  ) -> Int? {
    guard isValidState(with: unitLength) else { return nil }
    let resultRounded = (CGFloat(self) / unitLength).rounded(rounding.value)
    return Int(resultRounded)
  }

  private func isValidState(with unitLength: CGFloat) -> Bool {
    self > 0 && unitLength > 0 && unitLength.isFinite
  }

  /// Aka how many times does this character length fit into `self`
  /// Note: this uses `.floor()`, ssuming this is the default
  /// used by Swift's `Int()` init
//  public func toFloateger(
//    axis: Axis,
//    characterSize: CGSize
//  ) -> Int? {
//    /// Gets the relevant edge length for the given axis
//    let characterLength = axis.length(fromSize: characterSize)
//
//    /// Check that both the character length and self are non-zero
//    guard characterLength > 0, self > 0 else { return nil }
//    return Int(CGFloat(self) / characterLength)
//  }
//
//  public func toFloategerWidth(for characterSize: CGSize) -> Int? {
//    /// Gets the relevant edge length for the given axis
//    return self.toFloateger(axis: .horizontal, characterSize: characterSize)
//  }
//  public func toFloategerHeight(for characterSize: CGSize) -> Int? {
//    /// Gets the relevant edge length for the given axis
//    return self.toFloateger(axis: .vertical, characterSize: characterSize)
//  }
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

  /// Aka how many times does this character length fit into `self`
  /// Note: this uses `.floor()`, ssuming this is the default
  /// used by Swift's `Int()` init
  public func toFloateger(
    axis: Axis,
    characterSize: CGSize
  ) -> Int? {
    let lengthOfSelf = axis.length(fromSize: self)
    return lengthOfSelf.toFloateger(axis: axis, characterSize: characterSize)
  }

  public func toFloategerWidth(for characterSize: CGSize) -> Int? {
    return self.width.toFloategerWidth(for: characterSize)
  }

  public func toFloategerHeight(for characterSize: CGSize) -> Int? {
    return self.height.toFloategerHeight(for: characterSize)
  }
}
