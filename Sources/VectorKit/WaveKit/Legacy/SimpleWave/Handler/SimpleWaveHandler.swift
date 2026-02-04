//
//  SimpleWaveHandler.swift
//  BaseDemos
//
//  Created by Dave Coleman on 29/1/2026.
//

import CoreTools
import SwiftUI
import VectorKit

@Observable
final class SimpleWaveHandler {
  var wave: StyledWave = .init(
    .init(
      amp: 120,
      freq: 0.5,
      phase: 0
    ),
    config: WaveConfig(
      cycles: 4,
      sampleCount: 14,
      interpolation: .cubic()
    ),
    style: .init(line: .example, point: .example)
  )

  //  var wave: ConfiguredWave = .init(
  //    .init(
  //      amp: 120,
  //      freq: 0.5,
  //      phase: 0
  //    ),
  //    config: WaveConfig(
  //      cycles: 4,
  //      sampleCount: 14,
  //      interpolation: .cubic
  //    )
  //  )

  //  var points: Set<CGPoint> = []
  //  var points: [CGPoint] = []
  //  var radius: CGFloat = 10
  //  var lineColour: Color = .blue
  //  var dotColour: Color = .pink
  //  var path: Path = .init()
  var waveGenerator: WavePathGenerator = .init()
  let dot = Path(ellipseIn: CGRect(origin: .zero, size: CGSize(20, 20)))

  var waveState = ContinuousFloat()
}

extension SimpleWaveHandler {
  //  var path: Path {
  //    Path.makePath(
  //      using: points,
  //      interpolation: wave.config.interpolation
  //    )
  //  }
  //  var waveAnimated: AnimatedWave? {
  //    return AnimatedWave(
  //      wave: wave.wave,
  //      cycles: wave.config.cycles
  //    )
  //  }
}

//extension SimpleWaveHandler {
//  /// Returns a value oscillating between min and max, using sine wave math.
//  /// - Parameters:
//  ///   - time: The input value, typically a continuous time (e.g., seconds or frames).
//  ///   - min: The minimum output value.
//  ///   - max: The maximum output value.
//  ///   - speed: How fast the oscillation cycles (radians per second or per time unit).
//  func oscillatingSineWave(
//    at time: CGFloat,
//    min: CGFloat,
//    max: CGFloat,
//    speed: CGFloat = 1.0
//  ) -> CGFloat {
//    let amplitude = (max - min) / 2
//    let mid = (max + min) / 2
//    let phase = time * speed
//    return mid + amplitude * sin(phase)
//  }
//}
//
//
