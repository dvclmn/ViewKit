//
//  Model+Config.swift
//  LilyPad
//
//  Created by Dave Coleman on 6/5/2025.
//

import Foundation

public struct StrokeConfiguration: Hashable, Sendable, Codable {
  
  /// Below are used in `StrokeWidthHandler/calculateStrokeWidth`
  var minStrokeWidth: Double = 1.0
  var maxStrokeWidth: Double = 100
  
  /// How much does a stroke's *speed* affect it's *width*.
  /// Negative values result in inversion of thick vs thin at
  /// high vs low speeds
  var speedSensitivity: Double = 3
  
  var curveType: CatmullRom.SplineVariant = .centripetal

  /// Both used in `StrokeEngine/shouldAddPoint`
  var minDistanceBeforeAddingPoint: Double = 90
  
  /// Aka a speed value that is considered slow. This is used to sample points
  /// more densely, to give more control/accuracy to slow, deliberate strokes.
  ///
  /// Anything *below this speed*, will mean a point is added, no filtering.
  ///
  /// Note: This means low values for this property result in less points overall,
  /// as you have to be drawing really slowly to hit the slow speed threshold.
  ///
  /// Higher values == more points added, as it's easier to go below the threshold.
  var slowMovementThreshold: Double = 2
  
  /// Used in `CanvasView`, within `handler.strokeHandler.engine.drawStroke()`
//  var pointDensity: Int = 2
  
//  var velocitySensitivity: Double = 0.5
  
//  var maxThinningSpeed: Double = 3.0
  
  static let `default` = StrokeConfiguration()
}

extension StrokeConfiguration {
  var averageStrokeWidth: Double {
    (minStrokeWidth + maxStrokeWidth) / 2
  }
}
