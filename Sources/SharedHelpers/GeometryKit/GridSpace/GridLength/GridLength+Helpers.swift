//
//  GridLength+Helpers.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 7/1/2026.
//

extension GridLength {
  public var gridLength: Int { count }
  public var screenLength: CGFloat { screenLength() }
  
  public func screenLength(fallback: CGFloat = 0) -> CGFloat {
    count.toScreenLength(using: unitLength) ?? fallback
  }
  
  public func clamped(min: Int, max: Int) -> Self {
    let newCount = self.count.clamped(min, max)
    return GridLength(count: newCount, unitLength: self.unitLength)
  }
}

extension GridLength: Comparable {
  public static func < (
    lhs: GridLength,
    rhs: GridLength
  ) -> Bool {
    lhs.count < rhs.count
  }
}
