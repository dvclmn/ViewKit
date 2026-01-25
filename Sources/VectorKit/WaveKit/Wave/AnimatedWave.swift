//
//  AnimatedWave.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 22/1/2026.
//

import Foundation

public struct AnimatedWave {
  var wave: any WaveShaped
  var state: ContinuousParameter
  //  var state: WaveState

  public init(
    wave: any WaveShaped,
    state: ContinuousParameter
  ) {
    self.wave = wave
    self.state = state
  }
}

extension AnimatedWave {
  /// ```
  /// var wave = Wave(frequency: 0.5, amplitude: 50, waveform: .sine)
  /// var state = WaveAttributeState(initialFrequency: wave.frequency, initialPhase: wave.phase)
  /// var animated = AnimatedWave(wave: wave, state: state)
  ///
  /// let value = animated.modulation(normalisedIndex: 0.3, cycles: 2)
  /// print("Wave value:", value)
  ///
  /// state.updateFrequency(to: 1.0, currentPhase: wave.phase)
  /// state.updatePhase(to: 0.25, currentFrequency: wave.frequency)
  ///
  /// ```
  /// Get the modulation value for a given time and normalized index
  public func modulation(
    currentTime: TimeInterval = Date().timeIntervalSinceReferenceDate,
    normalisedIndex: CGFloat,
    cycles: CGFloat
  ) -> CGFloat {
    let phase = state.effectivePhase(
      currentTime: currentTime,
      frequency: wave.frequency
    )
    //    let phase = state.effectivePhase(
    //      currentTime: currentTime,
    //      normalisedIndex: normalisedIndex,
    //      cycles: cycles,
    //      frequency: wave.frequency,
    //      phaseOffset: wave.phase
    //    )
    let value = wave.waveform.sample(phase: phase)
    return CGFloat(wave.amplitude * value)
  }

  /// `value = A · sin(ωt + φ)`
  ///
  /// `A` = amplitude
  /// `ω` = angular frequency (omega)
  /// `t` = time
  /// `φ` = phase offset
  ///
  /// `2 * .pi * frequency * time`
  /// Means I am converting cycles per second → radians per second
  /// Which sine requires, because `sin()` lives in radians.
  public func modulation(
    for wave: any WaveShaped,
    effectiveTime: TimeInterval,
    normalisedIndex: CGFloat,
    cycles: CGFloat
  ) -> CGFloat {

    let freq = wave.frequency
    let phase =
      effectiveTime * wave.frequency  // temporal advance
      + normalisedIndex * cycles  // spatial distribution
      + wave.phase  // static offset

    let value = wave.waveform.sample(phase: phase)
    return wave.amplitude * value
  }

}

//  mutating func getPointsAlongPath(time: CGFloat, size: CGSize, resolution: Int = 100) -> [(CGPoint, CGFloat)] {
//    var points: [(CGPoint, CGFloat)] = []
//
//    // Update smoothed parameters
//    update(at: time)
//
//    for i in 0..<resolution {
//      let progress = CGFloat(i) / CGFloat(resolution - 1)
//      let x = progress * size.width
//
//      // Use smoothed parameters for calculations
//      let y = baseWaveform.getValue(
//        at: time,
//        frequency: smoothedFrequency.value,
//        amplitude: smoothedAmplitude.value,
//        phaseOffset: smoothedPhase.value + progress
//      )
//
//      let point = CGPoint(
//        x: x,
//        y: size.height / 2 + CGFloat(y) * size.height / 3
//      )
//
//      points.append((point, progress))
//    }
//
//    return points
//  }
