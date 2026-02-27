//
//  Unit+Extensions.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 27/2/2026.
//

import Foundation

// MARK: - Int extension
extension Int {
  
  public func toScreenLength(
    using unitLength: CGFloat,
  ) -> CGFloat? {
    guard isSafeToConvert(self, unitLength: unitLength) else { return nil }
    let result = CGFloat(self) * unitLength
    return result
  }
  
  public func toScreenLength(
    along axis: GridAxis,
    mapping: AxisMapping = .default,
    using unitSize: CGSize?,
  ) -> CGFloat? {
    guard let unitSize else { return nil }
    let length = unitSize.value(along: axis, mapping: mapping)
    return toScreenLength(using: length)
  }
  
}
