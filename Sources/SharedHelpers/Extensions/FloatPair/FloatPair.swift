//
//  FloatPair.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 15/12/2025.
//

import Foundation

public protocol FloatPair {
  associatedtype Value: BinaryFloatingPoint
  var first: Value { get }
  var second: Value { get }
}

extension CGPoint: FloatPair {
  public var first: CGFloat { self.x }
  public var second: CGFloat { self.y }
}

extension CGSize: FloatPair {
  public var first: CGFloat { self.width }
  public var second: CGFloat { self.height }
}
