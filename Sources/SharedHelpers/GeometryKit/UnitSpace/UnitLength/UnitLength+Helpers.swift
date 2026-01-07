//
//  UnitLength+Helpers.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 7/1/2026.
//

import Foundation

extension UnitLength {
  public var gridLength: Int { count }
  public var screenLength: CGFloat { screenLength() }
  
  public func screenLength(fallback: CGFloat = 0) -> CGFloat {
    count.toScreenLength(using: unitLength) ?? fallback
  }
  
  public func clamped(min: Int, max: Int) -> Self {
    let newCount = self.count.clamped(min, max)
    return UnitLength(count: newCount, unitLength: self.unitLength)
  }
}

extension UnitLength: Comparable {
  public static func < (
    lhs: UnitLength,
    rhs: UnitLength
  ) -> Bool {
    lhs.count < rhs.count
  }
}
