//
//  Model+Config.swift
//  AnimationPlayground
//
//  Created by Dave Coleman on 1/2/2025.
//

import ColourKit
import Foundation

/// Important:
/// How is `BreathingWave` different to a wave, if at all?
/// Maybe it more just contains waves?
public struct WaveStack: Codable, Sendable, Equatable {
//public struct BreathingWave: Codable, Sendable, Equatable {
  
//  public var colour: RGBColour
//  public var colourSecondary: RGBColour
  
  let lineStyle: LineStyle
  let pointStyle: PointStyle
  
  let waves: [Wave.ID: WaveDescriptor]

  /// The base circle radius.
//  public var circleRadius: CGFloat

  /// The total number of circles (affects normalisation but not the wave shapes).
  /// Could also be thought of as sample count
  public var count: Int

  /// ~~When shouldMaintainHeight is true, no matter what count is,
  /// these circles are “packed” into this height.~~
  ///
  /// How much of the vertical space the total wave takes up
  /// Aka vertical frequency
  public var compressionFactor: CGFloat

  /// Horizontal left/right motion parameters.
  public var horizontalWave: WaveModulator

  /// Vertical spacing between circles (used when shouldMaintainHeight == false).
//  public var spacing: CGFloat

  /// Breathing (spacing) wave: modulates the vertical position.
  /// (When shouldMaintainHeight is true, the circles are laid out
  ///  over a fixed height, and then the breathing effect is added.)
  public var verticalWave: WaveModulator
//  public var spacingWave: WaveModulator

//  public var shouldMaintainHeight: Bool

  /// New: a modulation for the circle radius (so the circles can “pulse”).
  public var radiusWave: WaveModulator

  public init(
    colour: RGBColour,
    colourSecondary: RGBColour,
    circleRadius: CGFloat,
    count: Int,
    compressionFactor: CGFloat,
    horizontalWave: WaveModulator,
    verticalWave: WaveModulator,
    radiusWave: WaveModulator
//    colour: RGBColour = .purple,
//    colourSecondary: RGBColour = .orange,
//    circleRadius: CGFloat = 25,
//    count: Int = 60,
//    compressionFactor: CGFloat = 300,
//    horizontalWave: WaveModulator = .init(
//      isEnabled: true,
//      amp: 70,
//      freq: 2,
//      phase: 0.4,
//      cycles: 3
//    ),
//    spacingWave: WaveModulator =
//      .init(
//        isEnabled: true,
//        amp: 10,
//        freq: 1,
//        phase: 0,
//        cycles: 3
//      ),
//    radiusWave: WaveModulator =
//      .init(
//        isEnabled: true,
//        amp: 5,
//        freq: 1,
//        phase: 0,
//        cycles: 3
//      )
  ) {
    self.colour = colour
    self.colourSecondary = colourSecondary
    self.circleRadius = circleRadius
    self.horizontalWave = horizontalWave
    self.verticalWave = verticalWave
    self.compressionFactor = compressionFactor
    self.count = count
    self.radiusWave = radiusWave
  }
}
