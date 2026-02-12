//
//  BreathingKeys.swift
//  BaseDemos
//
//  Created by Dave Coleman on 26/1/2026.
//

import Foundation
import VectorKit

public enum VerticalWave: WaveKey {
  public static let displayName = "Vertical"
  public static let codingKey = "vertical"

  /// Amplitude contributes greatly to the overall width of the wiggle
  public static let defaultValue = ConfiguredWave(
    amplitude: 20, frequency: 0.2
  )
}

public enum HorizontalWave: WaveKey {
  public static let displayName = "Horizontal"
  public static let codingKey = "horizontal"

  /// Amplitude here controls the loopiness / exaggeration of the vertical kinks
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
