//
//  BFP+Conversions.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 21/9/2025.
//

import Foundation

extension BinaryFloatingPoint {

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
  //  public static func omega(frequency: Self) -> Self {
  //    return .pi * 2 * frequency
  //  }

  public var toDouble: Double { Double(self) }
  public var toFloat: Float { Float(self) }

  public func removingZoom(
    _ zoom: Self,
    clampedTo range: ClosedRange<Self>? = nil,
    sensitivity: Self? = nil
  ) -> Self {
    guard zoom.isGreaterThanZero, range?.isGreaterThanZero ?? false else {
      return self
    }
    //    guard let range else {
    //      return self / zoom
    //    }

    let effectiveZoom = range.map { zoom.clamped(to: $0) } ?? zoom

    if let sensitivity {
      let s = sensitivity.clamped(to: 0...1)
      return self * Self(pow(Double(effectiveZoom), Double(s - 1)))
    }

    return self / effectiveZoom
    //    let clampedZoom = zoom.clamped(to: range)

    //    if let sensitivity {
    //      let clampedSensitivity = sensitivity.clamped(to: 0...1)
    //      let compensation = Self(
    //        pow(Double(clampedZoom), Double(clampedSensitivity - 1))
    //      )
    //      return self * compensation
    ////      let exponent = clampedSensitivity - 1
    ////      return self * Self(pow(Double(clampedZoom), Double(exponent)))
    ////      return self * Self(pow(Double(zoom), Double(clampedSensitivity) - 1))
    //    }
    //
    //    return self / clampedZoom
  }

  /// This removes a zoom range which has been normalised from 0-1

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

    guard range.isGreaterThanZero,
      curve > 0
    else { return zoom }

    let upper = range.upperBound
    let lower = range.lowerBound

    /// Normalize the zoom level to 0...1 range
    /// This method also clamps to range
    let normalised = zoom.normalised(in: range)

    /// Calculate threshold positions in normalized space
    /// Ensure no unexpected invalid values by clamping
    let low = lowSensitivityThreshold.clamped(to: range)
    let high = highSensitivityThreshold.clamped(to: range)

    let lowThresholdNorm = (low - lower) / (upper - lower)
    let highThresholdNorm = (high - lower) / (upper - lower)

    let transformedZoom: Double

    if normalised <= lowThresholdNorm {
      /// Low zoom range: reduce sensitivity (expand the curve - slower response)
      let localNorm = normalised / lowThresholdNorm

      /// Use curve to slow down response
      let slowed = CGFloat(curve).slowResponse(localNorm)

      transformedZoom = slowed * lowThresholdNorm

    } else if normalised >= highThresholdNorm {
      /// High zoom range: increase sensitivity (compress the curve - faster response)
      let localNorm = (normalised - highThresholdNorm) / (1.0 - highThresholdNorm)

      /// Inverse curve for faster response
      let faster = CGFloat(curve).fastResponse(localNorm)
      //      let compressed = pow(localNorm, 1.0 / curve)
      transformedZoom = highThresholdNorm + faster * (1.0 - highThresholdNorm)

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
    guard sensitivity > 0 else { return zoom }
    let normalised = zoom.normalised(in: range)
    let transformed = pow(normalised, sensitivity)
    return transformed.denormalised(in: range)
  }

}

extension CGFloat {

  /// Where self is the curve
  func slowResponse(_ x: Self) -> Self { pow(x, self) }

  /// Where self is the curve
  func fastResponse(_ x: Self) -> Self { pow(x, 1 / self) }

}
