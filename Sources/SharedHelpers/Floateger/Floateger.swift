//
//  Floateger.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 13/10/2025.
//

import SwiftUI

public typealias Floateger = (count: Int, length: CGFloat)
public typealias Sizeger = (count: Int, length: CGSize)

public struct IntFloat {
  let count: Int
}

public struct IntSize {
  let width: Int
  let height: Int
  
  public init(
    width: Int,
    height: Int
  ) {
    self.width = width
    self.height = height
  }
}

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
  /// Converts a character count (`self`) to a CGFloat dimension
  /// based on the provided `characterSize`
  public func toFloateger(
    axis: Axis,
    characterSize: CGSize
  ) -> CGFloat? {
    guard self > 0 else { return nil }
    
    let characterLength = axis.length(fromSize: characterSize)
    guard characterLength > 0 else { return nil }
    
    return CGFloat(self) * characterLength
  }
  
  public func toFloategerWidth(for characterSize: CGSize) -> CGFloat? {
    return self.toFloateger(axis: .horizontal, characterSize: characterSize)
  }
  public func toFloategerHeight(for characterSize: CGSize) -> CGFloat? {
    return self.toFloateger(axis: .vertical, characterSize: characterSize)
  }

}
