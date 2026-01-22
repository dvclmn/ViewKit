//
//  AnimatedWave.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 22/1/2026.
//

import Foundation

public struct AnimatedWave {
  var wave: any WaveShaped
  var state: WaveAttributeState

  public init(
    wave: any WaveShaped,
    state: WaveAttributeState
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
    normalisedIndex: Double,
    cycles: Double
  ) -> CGFloat {
    let phase = state.effectivePhase(
      currentTime: currentTime,
      normalisedIndex: normalisedIndex,
      cycles: cycles,
      frequency: wave.frequency,
      phaseOffset: wave.phase
    )
    let value = wave.waveform.sample(phase: phase)
    return CGFloat(wave.amplitude * value)
  }
}
