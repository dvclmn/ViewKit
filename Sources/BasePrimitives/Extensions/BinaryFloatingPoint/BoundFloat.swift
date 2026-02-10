//
//  BoundFloat.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 10/2/2026.
//

import Foundation

public struct BoundFloat<T: BinaryFloatingPoint> {
  public var value: T
  public let range: ClosedRange<T>
  public let step: T?
  
  public init(
    _ value: T,
    range: ClosedRange<T>,
    step: T? = nil
  ) {
    self.value = value
    self.range = range
    self.step = step
  }
}

//extension BoundFloat where T: Strideable {
//  public init(
//    _ value: T,
//    range: ClosedRange<T>,
//    step: T
//  ) {
//    self.value = value
//    self.range = range
//    self.step = step
//  }
//}

extension BoundFloat {
  public var clamped: T {
    value.clamped(to: range)
  }
}
