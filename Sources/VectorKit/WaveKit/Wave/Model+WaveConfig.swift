//
//  Model+Config.swift
//  AnimationPlayground
//
//  Created by Dave Coleman on 1/2/2025.
//

import ColourKit
import Foundation

public struct WaveConfig: Codable, Sendable, Equatable {
  public var colour: RGBColour
  public var colourSecondary: RGBColour

  /// The base circle radius.
  public var circleRadius: Double

  /// The total number of circles (affects normalisation but not the wave shapes).
  public var count: Int

  /// When shouldMaintainHeight is true, no matter what count is,
  /// these circles are “packed” into this height.
  public var height: Double

  /// Horizontal left/right motion parameters.
  public var horizontalWave: WaveModulator

  /// Vertical spacing between circles (used when shouldMaintainHeight == false).
  public var spacing: Double

  /// Breathing (spacing) wave: modulates the vertical position.
  /// (When shouldMaintainHeight is true, the circles are laid out
  ///  over a fixed height, and then the breathing effect is added.)
  public var spacingWave: WaveModulator

  public var shouldMaintainHeight: Bool

  /// New: a modulation for the circle radius (so the circles can “pulse”).
  public var radiusWave: WaveModulator

  public init(
    colour: RGBColour = .purple,
    colourSecondary: RGBColour = .orange,
    circleRadius: Double = 25,
    count: Int = 60,
    height: Double = 300,
    spacing: Double = 16,
    shouldMaintainHeight: Bool = true,
    horizontalWave: WaveModulator = .init(
      isEnabled: true,
      amp: 70,
      freq: 2,
      phase: 0.4,
      cycles: 3
    ),
    spacingWave: WaveModulator =
      .init(
        isEnabled: true,
        amp: 10,
        freq: 1,
        phase: 0,
        cycles: 3
      ),
    radiusWave: WaveModulator =
      .init(
        isEnabled: true,
        amp: 5,
        freq: 1,
        phase: 0,
        cycles: 3
      )
  ) {
    self.colour = colour
    self.colourSecondary = colourSecondary
    self.circleRadius = circleRadius
    self.horizontalWave = horizontalWave
    self.spacing = spacing
    self.spacingWave = spacingWave
    self.height = height
    self.shouldMaintainHeight = shouldMaintainHeight
    self.count = count
    self.radiusWave = radiusWave
  }
}
