//
//  Model+StrokeWidth.swift
//  LilyPad
//
//  Created by Dave Coleman on 5/5/2025.
//

import ToolKit
import Foundation
import GestureKit
import VectorKit

struct StrokeWidthHandler {

  static func calculateStrokeWidth(
    speed: CGFloat,
    pressure: CGFloat?,
    config: StrokeConfiguration,
  ) -> CGFloat {

    let minValue: CGFloat = 1.0
    let curveExponent: CGFloat = 1.0

    /// Why 30? Magic number alert
    let speedSensitivity = config.speedSensitivity * 30
    let maxWidth = config.maxStrokeWidth
    let minWidth = config.minStrokeWidth

    let clamped = min(max(speed, minValue), speedSensitivity)
    let normalised = (clamped - minValue) / (speedSensitivity - minValue)
    let adjusted = pow(normalised, curveExponent)

    return config.maxStrokeWidth - (maxWidth - minWidth) * adjusted
  }

  static func calculateStrokeWidthAlt(
    speed: CGFloat,
    pressure: CGFloat?,
    config: StrokeConfiguration
  ) -> CGFloat {

    let minValue: CGFloat = 0
    let curveExponent: CGFloat = 1.0
    let speedSensitivity = config.speedSensitivity
    let maxWidth = config.maxStrokeWidth
    let minWidth = config.minStrokeWidth
    let averageWidth = (minWidth + maxWidth) / 2

    /// Handle zero sensitivity - return average width
    guard speedSensitivity != 0 else {
      return averageWidth
    }

    /// Use absolute value for calculations, preserve sign for direction
    let absSensitivity = abs(speedSensitivity)
    let isInverted = speedSensitivity < 0

    /// Clamp speed to sensitivity range
    let clamped = min(max(speed, minValue), absSensitivity)
    let normalised = (clamped - minValue) / (absSensitivity - minValue)
    let adjusted = pow(normalised, curveExponent)

    let widthResult: CGFloat
    if isInverted {
      /// Negative values: Higher speeds = thicker stroke, lower speeds = less variation
      /// At speed 0: return average width (less variation)
      /// At max speed: return full range based on adjusted value
      let baseWidth = averageWidth
      let range = (maxWidth - minWidth) / 2
      widthResult = baseWidth + range * adjusted
    } else {
      /// Positive values: Higher speeds = thinner stroke (original inverse behavior)
      widthResult = maxWidth - (maxWidth - minWidth) * adjusted
    }

    //      print("""
    //      ====
    //      # Configuration
    //      Speed Sensitivity: \(speedSensitivity.displayString)
    //      Is Inverted? \(isInverted)
    //      Min Stroke Width: \(minWidth.displayString)
    //      Max Stroke Width: \(maxWidth.displayString)
    //
    //      # Result
    //      Width: \(widthResult.displayString)
    //      ====
    //      """)

    return widthResult
  }

  static func interpolatedWidth(
    segment: CatmullRomSegment,
    touchPoints: [TouchPoint],
    pointIndex: Int,
    t: CGFloat,
    config: StrokeConfiguration
  ) -> CGFloat? {
    guard pointIndex + 3 < touchPoints.count else {
      print(
        "Width interpolation error: \"pointIndex + 3\" (\(pointIndex + 3)) was not less than \"touchPoints.count\" (\(touchPoints.count))."
      )
      return nil
    }

    /// Grab the four corresponding width values
    let widths: [CGFloat] = (pointIndex..<pointIndex + 4)
      .map { index in
        let point = touchPoints[index]
        return StrokeWidthHandler.calculateStrokeWidth(
          speed: point.velocity.speed,
          pressure: point.pressure,
          config: config
        )
      }

    return segment.interpolateScalar(values: widths, at: t)
  }
}
