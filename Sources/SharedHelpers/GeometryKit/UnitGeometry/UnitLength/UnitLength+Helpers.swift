//
//  UnitLength+Helpers.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 7/1/2026.
//

import Foundation

extension UnitLength {
  public var gridLength: Int { magnitude }
  public var screenLength: CGFloat { screenLength() }
  
  public func screenLength(fallback: CGFloat = 0) -> CGFloat {
    magnitude.toScreenLength(using: unitLength) ?? fallback
  }
  
  public func clamped(min: Int, max: Int) -> Self {
    let newCount = self.magnitude.clamped(min, max)
    return UnitLength(count: newCount, unitLength: self.unitLength)
  }
}

