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
  public func modulation(
    effectiveTime: TimeInterval,
    normalisedIndex: Double,
    cycles: Double
  ) -> CGFloat {
    let phase = state.effectivePhase(
      currentTime: now,
      normalisedIndex: normalisedIndex,
      cycles: cycles
    )
    let value = wave.waveform.sample(phase: phase)
    return wave.amplitude * value
  }
}
