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

  /// omega is inherently “radians per second”
  /// In the below, `self` is the frequency (Hz)
  /// `ω = 2πf`
  public var omega: Self { self * .pi * 2 }

  public var toDouble: Double { Double(self) }
  public var toFloat: Float { Float(self) }
  public var toCGFloat: CGFloat { CGFloat(self) }


}
