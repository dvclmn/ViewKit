//
//  Debug+Helpers.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 10/1/2026.
//

import SwiftUI
import BasePrimitives

extension CGPoint {

  public func debugColour(unitPoint: UnitPoint, in size: CGSize) -> Color {
    guard self.isNearUnitPoint(unitPoint, in: size) else {
      return Color.clear
    }
    return unitPoint.debugColour
  }
}
