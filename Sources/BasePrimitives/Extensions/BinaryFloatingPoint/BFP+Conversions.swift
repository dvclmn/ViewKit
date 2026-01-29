//
//  BFP+Conversions.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 21/9/2025.
//

import SwiftUI

extension BinaryFloatingPoint {

  public var toAngle: Angle { .degrees(Double(self)) }

  public func toPercent(within range: ClosedRange<Self>) -> Self {
    self.normalised(in: range) * 100
  }

  //  public func toPercent(within range: ClosedRange<Self>) -> Self {
  //    let normalised: Double = Double(self.normalised(in: range))
  //    return Self(normalised * 100)
  //  }

  public var toDurationInSeconds: Duration { Duration.seconds(Double(self)) }

  public var degreesToRadians: Self { self * .pi / 180 }
  public var radiansToDegrees: Self { self * 180 / .pi }

  /// Where `self` is the frequency
  /// `ω = 2πf`
  public var omega: Self { self * .pi * 2 }

  public var toDouble: Double { Double(self) }
  public var toFloat: Float { Float(self) }
  public var toCGFloat: CGFloat { CGFloat(self) }

  /// Where self is the curve
  func slowResponse(_ x: Self) -> Self { Self(pow(CGFloat(x), CGFloat(self))) }

  /// Where self is the curve
  func fastResponse(_ x: Self) -> Self { Self(pow(CGFloat(x), CGFloat(1 / self))) }

}
