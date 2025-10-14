//
//  Grid+Extensions.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 14/10/2025.
//

import SwiftUI

extension BinaryFloatingPoint {

  /// Aka how many times does this character length fit into `self`
  /// Note: this uses `.floor()`, ssuming this is the default
  /// used by Swift's `Int()` init
  public func toFloateger(
    axis: Axis,
    characterSize: CGSize
  ) -> Int? {
    /// Gets the relevant edge length for the given axis
    let characterLength = axis.length(fromSize: characterSize)

    /// Check that both the character length and self are non-zero
    guard characterLength > 0, self > 0 else { return nil }
    return Int(CGFloat(self) / characterLength)
  }

  public func toFloategerWidth(for characterSize: CGSize) -> Int? {
    /// Gets the relevant edge length for the given axis
    return self.toFloateger(axis: .horizontal, characterSize: characterSize)
  }
  public func toFloategerHeight(for characterSize: CGSize) -> Int? {
    /// Gets the relevant edge length for the given axis
    return self.toFloateger(axis: .vertical, characterSize: characterSize)
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

extension Int {

  public func toScreenLength(
    using unitLength: CGFloat,
    fallback: CGFloat? = nil
  ) -> CGFloat? {
    guard isValidState(with: unitLength) else { return fallback }
    return CGFloat(self) * unitLength
  }

  private func isValidState(with unitLength: CGFloat) -> Bool {
    self >= 0 && unitLength > 0 && unitLength.isFinite
  }

  //  public func toScreenLength(using unitLength: CGFloat) -> CGFloat? {
  //    guard self >= 0, unitLength > 0, unitLength.isFinite else { return nil }
  ////    guard self > 0, unitLength > 0 else { return nil }
  //    return CGFloat(self) * unitLength
  //  }

  /// Converts a character count (`self`) to a CGFloat dimension
  /// based on the provided `characterSize`
  public func toScreenLength(
    along axis: Axis,
    using unitSize: CGSize,
    fallback: CGFloat? = nil
  ) -> CGFloat? {
    let unitLength = axis.length(fromSize: unitSize)
    return toScreenLength(using: unitLength, fallback: fallback)
//    guard isValidState(with: unitLength)
//    return CGFloat(self) * unitLength
  }

//  public func toScreenWidth(for unitSize: CGSize) -> CGFloat? {
//    return self.toScreenLength(axis: .horizontal, unitSize: unitSize)
//  }
//  public func toScreenHeight(for unitSize: CGSize) -> CGFloat? {
//    return self.toScreenLength(axis: .vertical, unitSize: unitSize)
//  }

}
