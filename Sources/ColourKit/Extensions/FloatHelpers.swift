//
//  FloatHelpers.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 8/10/2025.
//

import Foundation

extension BinaryFloatingPoint {
  public func hueWrapped() -> Self {
    let value = self.truncatingRemainder(dividingBy: 1.0)
    return value < 0 ? value + 1.0 : value
  }
}
