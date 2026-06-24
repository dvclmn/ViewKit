//
//  Document+Examples.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 24/6/2026.
//

import ColourTools

extension ConfiguredWave {
  public static var waveHExample: Self {
    .init(
      .init(
        amp: 100,
        freq: 0.3,
        phaseTurns: 0.6,
        waveform: .sine(),
      ),
      config: .init(
        cycles: 4,
        noise: 0,
      ),
    )
  }

  public static var waveVExample: Self {
    .init(
      .init(
        amp: 80,
        freq: 0.2,
        phaseTurns: 0,
        waveform: .sine(),
      ),
      config: .init(
        cycles: 2,
        noise: 0,
      ),
    )
  }

  public static var waveRExample: Self {
    .init(
      .init(
        amp: 0.5,
        freq: 0.2,
        phaseTurns: 0,
        waveform: .sine(),
      ),
      config: .init(
        cycles: 2,
        noise: 0,
      ),
    )
  }
}

extension WaveStyle {
  public static var originalExample: Self {
    .init(
      line: .init(
        colour: .forestgreen,
        lineWidth: 22,
      ),
      point: .init(
        shape: .circle,
        radius: 30,
        colour: RGBColour(0.3, 0.9, 0.3),
        colourMixStrength: 3.4,
      ),
    )
  }
}
