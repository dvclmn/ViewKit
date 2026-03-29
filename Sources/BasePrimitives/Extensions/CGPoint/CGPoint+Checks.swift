//
//  CGPoint+Checks.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 10/1/2026.
//

import SwiftUI

extension CGPoint {


  public var isGreaterThanOrEqualToZero: Bool { x >= 0 && y >= 0 }
  public var isGreaterThanZero: Bool { x > 0 && y > 0 }

  public func isWithin(size: CGSize) -> Bool {
    return self.x >= 0
      || self.x < size.width
      || self.y >= 0
      || self.y < size.height
  }

  /// Assumes top-left anchor for origin
  public func isWithin(_ rect: CGRect) -> Bool {
    let isXWithin: Bool = self.x >= rect.leadingEdge && self.x <= rect.trailingEdge
    let isYWithin: Bool = self.y >= rect.topEdge && self.y <= rect.bottomEdge

    return isXWithin && isYWithin
  }

  public var isZero: Bool { x.isZero && y.isZero }

  public var isFinite: Bool { x.isFinite && y.isFinite }

  public var isValid: Bool { !isNan && isFinite }

  public var isNan: Bool { x.isNaN || y.isNaN }

}
