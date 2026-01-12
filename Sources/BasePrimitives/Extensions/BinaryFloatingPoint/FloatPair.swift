//
//  FloatPair.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 15/12/2025.
//

import Foundation

/// An attempt to describe types that hold onto two or more float values
/// Relies on a predictable/conventional order
//public protocol MultiFloat {
//  init(newValue: CGFloat...)
//}

/// Important: this protocol does not (yet?) provide flexibility
/// regarding what
public protocol FloatPair {
  associatedtype Value: BinaryFloatingPoint
  var first: Value { get }
  var second: Value { get }

  init(first: Value, second: Value)
}

extension CGPoint: FloatPair {

  public init(first: CGFloat, second: CGFloat) {
    self.init(x: first, y: second)
  }
  public var first: CGFloat { self.x }
  public var second: CGFloat { self.y }

}

extension CGSize: FloatPair {
  public init(first: CGFloat, second: CGFloat) {
    self.init(width: first, height: second)
  }
  public var first: CGFloat { self.width }
  public var second: CGFloat { self.height }
}
