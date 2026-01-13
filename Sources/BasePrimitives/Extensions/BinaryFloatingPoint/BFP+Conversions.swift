//
//  BFP+Conversions.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 21/9/2025.
//

import Foundation

extension BinaryFloatingPoint {

  public func toPercent(within range: ClosedRange<Self>) -> Self {
    let normalised: Double = Double(self.normalised(in: range))
    return Self(normalised * 100)
  }

  public var degreesToRadians: Self { self * .pi / 180 }
  public var radiansToDegrees: Self { self * 180 / .pi }

  public static func omega(frequency: Self) -> Self {
    return .pi * 2 * frequency
  }

  public var toDouble: Double { Double(self) }
  public var toFloat: Float { Float(self) }

  public func removingZoom(
    _ zoom: Self,
    clampedTo range: ClosedRange<Self>? = nil,
    sensitivity: Self? = nil
  ) -> Self {
    guard let range else {
      return self / zoom
    }
    let clampedZoom = zoom.clamped(to: range)

    if let sensitivity {
      let clampedSensitivity = sensitivity.clamped(to: 0...1)
      return self * Self(pow(Double(zoom), Double(clampedSensitivity) - 1))
    }

    return self / clampedZoom
  }

  /// This removes a zoom range which has been normalised from 0-1
  public func removingZoomPercent(_ zoomPercent: Self) -> Self {
    let result = Double(self) / pow(1 + Double(zoomPercent), 1)
    return Self(result)
  }

  /// Applies non-linear zoom scaling to provide better control at different zoom levels
  /// - Parameters:
  ///   - zoomLevel: The current zoom level (0.1...60)
  ///   - zoomRange: The valid zoom range
  ///   - lowSensitivityThreshold: Zoom level below which sensitivity is reduced (default: 1.0)
  ///   - highSensitivityThreshold: Zoom level above which sensitivity is increased (default: 5.0)
  ///   - curve: The power curve factor (default: 1.5). Higher values = more dramatic curve
  /// - Returns: The transformed zoom scale to apply to the view
  public static func nonLinearZoomScale(
    _ zoom: Double,
    in range: ClosedRange<Double>,
    lowSensitivityThreshold: Double = 1.0,
    highSensitivityThreshold: Double = 5.0,
    curve: Double = 1.5
  ) -> Double {

    let upper = range.upperBound
    let lower = range.lowerBound

    /// Clamp the zoom level to the valid range
    let clamped = zoom.clamped(to: range)

    /// Normalize the zoom level to 0...1 range
    let normalised = (clamped - lower) / (upper - lower)

    /// Calculate threshold positions in normalized space
    let lowThresholdNorm = (lowSensitivityThreshold - lower) / (upper - lower)
    let highThresholdNorm = (highSensitivityThreshold - lower) / (upper - lower)

    let transformedZoom: Double

    if normalised <= lowThresholdNorm {
      /// Low zoom range: reduce sensitivity (expand the curve - slower response)
      let localNorm = normalised / lowThresholdNorm

      /// Use curve to slow down response
      let expanded = pow(localNorm, curve)

      transformedZoom = expanded * lowThresholdNorm

    } else if normalised >= highThresholdNorm {
      /// High zoom range: increase sensitivity (compress the curve - faster response)
      let localNorm = (normalised - highThresholdNorm) / (1.0 - highThresholdNorm)
      let compressed = pow(localNorm, 1.0 / curve)  // Inverse curve for faster response
      transformedZoom = highThresholdNorm + compressed * (1.0 - highThresholdNorm)

    } else {
      /// Middle range: linear scaling
      transformedZoom = normalised
    }

    /// Convert back to actual zoom range
    return transformedZoom.denormalised(in: range)
    //    return transformedZoom * (upper - lower) + lower
  }

  /// Simplified non-linear zoom scaling using a single curve parameter
  /// - Parameters:
  ///   - zoom: The current zoom level
  ///   - range: The valid zoom range
  ///   - sensitivity: Controls the curve (values < 1.0 = less sensitive at low zoom, values > 1.0 = more sensitive at low zoom)
  /// - Returns: The transformed zoom scale
  public static func simpleNonLinearZoomScale(
    _ zoom: Double,
    range: ClosedRange<Double>,
    sensitivity: Double = 1.3
  ) -> Double {
    let lower = range.lowerBound
    let upper = range.upperBound

    //    let clamped = zoom.clamped(to: range)
    //    let normalised = (clamped - lower) / (upper - lower)
    let normalised = zoom.normalised(in: range)
    let transformed = pow(normalised, sensitivity)
    return transformed.denormalised(in: range)
    //    return transformed * (upper - lower) + lower
  }

  //  private func clampedAndNormalised(in range: ClosedRange<Self>) -> Self {
  //    let clamped = clamped(to: range)
  //    let normalised = (clamped - range.lowerBound) / (range.upperBound - range.lowerBound)
  //    return normalised
  //  }

}
