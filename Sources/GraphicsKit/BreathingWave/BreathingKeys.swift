//
//  BreathingKeys.swift
//  BaseDemos
//
//  Created by Dave Coleman on 26/1/2026.
//

import Foundation
import VectorKit

/// Not every wave needs to have every attribute exposed to the user
/// for controlling. Some properties influence the overall wave shape
/// more than others, depending on how exactly it's drawn in the Canvas.
///
/// Trying to think of how to express this more concretely in the code.
///
/// E.g. `VerticalWave`'s `amplitude` contributes hugely to the overall
/// 'width' aspect of the final visual. In contrast, `DotRadiusWave`'s
/// `cycles` doesn't impact visuals nearly as much.
public enum VerticalWave: WaveKey {
  public static let displayName = "Vertical"
  public static let codingKey = "vertical"

  /// Amplitude: The 'width' of the wiggle overall
  public static let defaultValue = ConfiguredWave(
    amplitude: 20, frequency: 0.2
  )
}

public enum HorizontalWave: WaveKey {
  public static let displayName = "Horizontal"
  public static let codingKey = "horizontal"

  /// Amplitude: Controls the loopiness / exaggeration of the vertical kinks
  public static let defaultValue = ConfiguredWave(
    amplitude: 70, frequency: 0.9
  )
}
public enum DotRadiusWave: WaveKey {
  public static let displayName = "Dot Radius"
  public static let codingKey = "dotRadius"
  public static let defaultValue = ConfiguredWave(
    amplitude: 2, frequency: 0.1
  )
}
