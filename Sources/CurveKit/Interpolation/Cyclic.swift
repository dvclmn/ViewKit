//
//  Cyclic.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 7/10/2025.
//

extension BinaryFloatingPoint {
  
  /// Interpolate shortest path around colour wheel
  @available(*, deprecated, message: "Prefer SwiftUI's `VectorArithmetic/interpolated(towards:amount:)` instead")
  public func interpolated(
    towards other: Self,
    strength: Self
  ) -> Self {
    let delta = ((other - self + 1.5).truncatingRemainder(dividingBy: 1.0)) - 0.5
    return Self(self + delta * strength)
  }
  
  /// Useful for Hue
  public var degrees: Double { Double(self * 360) }
//  public init(degrees: Double) { Double(degrees / 360) }
}
