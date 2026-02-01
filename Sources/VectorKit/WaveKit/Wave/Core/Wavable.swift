//
//  Wavable.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 31/1/2026.
//

import Foundation

@dynamicMemberLookup
public protocol Wavable {
  associatedtype Value: WaveFloat
  var wave: Wave<Value> { get set }
  var config: WaveConfig<Value> { get set }
}

extension Wavable {
  public subscript<T>(dynamicMember keyPath: WritableKeyPath<Wave<Value>, T>) -> T{
    get { self.wave[keyPath: keyPath] }
    set { self.wave[keyPath: keyPath] = newValue }
  }

  /// Evaluates the wave at a specific point in space.
  /// - Parameters:
  ///   - state: The persistent ContinuousParameter for this specific wave.
  ///   - normalisedIndex: The normalisedIndex (0...1) of the current point.
  public func sample(
    state: ContinuousParameter<Value>,
    at normalisedIndex: Value
  ) -> Value {
    /// 1. Get the time-based phase from our persistent state
    let temporalPhase = state.currentPhase

    /// 2. Add spatial phase (cycles) and static offset (wave.phase)
    let spatialPhase = normalisedIndex * config.cycles
    let staticOffset = wave.phase

    let totalPhase = temporalPhase + spatialPhase + staticOffset
    let wrappedPhase = totalPhase - floor(totalPhase)

    /// 3. Run it through the waveform math. Wrap and Sample
    let value = wave.waveform.sample(phase: Float(wrappedPhase))
    return wave.amplitude * Self.Value(value)
  }
}
