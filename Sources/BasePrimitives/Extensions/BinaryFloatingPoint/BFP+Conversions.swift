//
//  BFP+Conversions.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 21/9/2025.
//

import Foundation

extension BinaryFloatingPoint {

  public func toPercent(within range: ClosedRange<Self>) -> Self {
    let normalised: Double = Double(self.normalised(from: range))
    return Self(normalised * 100)
  }

  public var degreesToRadians: Self { self * .pi / 180 }
  public var radiansToDegrees: Self { self * 180 / .pi }

  public static func omega(frequency: Self) -> Self {
    return .pi * 2 * frequency
  }
  
  public var toDouble: Double { Double(self) }
  public var toFloat: Float { Float(self) }

  
}
