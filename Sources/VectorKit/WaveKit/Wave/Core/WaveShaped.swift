//
//  WaveShaped.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 31/1/2026.
//

import Foundation

@dynamicMemberLookup
public protocol WaveShaped {
  associatedtype Value: WaveFloat

  //  var id: UUID { get }
  //  var amplitude: Value { get set }
  //  var frequency: Value { get set }
  //  var phaseRadians: Value { get set }
  ////  var phase: Value { get set }
  //  var waveform: Waveform { get set }

  var wave: Wave<Value> { get set }
  var config: WaveConfig<Value> { get set }
}

extension WaveShaped {
  public subscript<T>(dynamicMember keyPath: WritableKeyPath<Wave<Value>, T>) -> T {
    get { self.wave[keyPath: keyPath] }
    set { self.wave[keyPath: keyPath] = newValue }
  }

  /// Evaluates the wave at a specific point in space.
  /// - Parameters:
  ///   - state: The persistent ContinuousParameter for this specific wave.
  ///   - normalisedIndex: The normalisedIndex (0...1) of the current point.
  public func sample(
    state: ContinuousParameter<Value>,
    at normalisedIndex: Value,
    //    cycles: Value,
  ) -> Value {

    /// 1. Get the time-based phase from persistent state
    let temporalPhase = state.currentPhase

    /// 2. Add spatial phase (cycles) and static offset (wave.phase)
    let spatialPhase = normalisedIndex * config.cycles
    let staticOffset = wave.phaseRadians

    let totalPhase = temporalPhase + spatialPhase + staticOffset
    let wrappedPhase = totalPhase - floor(totalPhase)

    /// 3. Run it through the waveform math. Wrap and Sample
    let value = wave.waveform.sample(phase: wrappedPhase)
    return wave.amplitude * value
  }
}
