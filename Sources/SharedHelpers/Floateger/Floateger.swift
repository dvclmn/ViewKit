//
//  Floateger.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 13/10/2025.
//

import SwiftUI

//public enum Floateger {
//  case asInt(Int)
//  case asFloat(CGFloat)
//}

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
}

extension Int {
  /// Converts `self` to a float, based on provided `characterSize`
  public func toFloateger(
    axis: Axis,
//    characterCount: Int
    characterSize: CGSize
  ) -> CGFloat? {
    
    /// self is the number of characters
    
//    let characterLength = axis.length(fromSize: characterSize)
//    return charLength
//    let lengthOfSelf = axis.length(fromSize: self)
//    return lengthOfSelf.toFloateger(axis: axis, characterSize: characterSize)
  }
}
