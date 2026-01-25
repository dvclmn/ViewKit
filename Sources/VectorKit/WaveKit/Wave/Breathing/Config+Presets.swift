//
//  Config+Presets.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 22/1/2026.
//

import ColourKit
import Foundation

extension WaveConfig {
  public static var standard: Self {
    .init(
      colour: .purple,
      colourSecondary: .orange,
      circleRadius: 25,
      count: 60,
      compressionFactor: 0.1,
      horizontalWave: .init(
        isEnabled: true,
        amp: 70,
        freq: 2,
        phase: 0.4,
        cycles: 3
      ),
      verticalWave: .init(
        isEnabled: true,
        amp: 10,
        freq: 1,
        phase: 0,
        cycles: 3
      ),
      radiusWave: .init(
        isEnabled: true,
        amp: 5,
        freq: 1,
        phase: 0,
        cycles: 3
      )
    )
  }

  public static var springy: Self {
    .init(
      colour: .green,
      colourSecondary: .brown,
      circleRadius: 7,
      count: 70,
      compressionFactor: 0.9,
//      spacing: 16,
//      shouldMaintainHeight: true,
      
      horizontalWave: .init(
        isEnabled: true,
        amp: 70,
        freq: 0.4,
        phase: 0.4,
        cycles: 4
      ),
      verticalWave: .init(
        isEnabled: true,
        amp: 10,
        freq: 1,
        phase: 0,
        cycles: 3
      ),
      radiusWave: .init(
        isEnabled: true,
        amp: 0.2,
        freq: 0.4,
        phase: 0,
        cycles: 3
      )
    )
  }
}
