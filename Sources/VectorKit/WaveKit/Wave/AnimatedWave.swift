//
//  AnimatedWave.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 22/1/2026.
//

import Foundation

public struct AnimatedWave {
  public var wave: Wave
  public var cycles: Double
  
  public init(wave: Wave, cycles: Double) {
    self.wave = wave
    self.cycles = cycles
  }
  
  /// Evaluates the wave at a specific point in space.
  /// - Parameters:
  ///   - state: The persistent ContinuousParameter for this specific wave.
  ///   - index: The normalisedIndex (0...1) of the current point.
  public func sample(state: ContinuousParameter, at index: Double) -> CGFloat {
    // 1. Get the time-based phase from our persistent state
    let temporalPhase = state.currentPhase
    
    // 2. Add spatial phase (cycles) and static offset (wave.phase)
    let spatialPhase = index * cycles
    let staticOffset = wave.phase
    
    let totalPhase = temporalPhase + spatialPhase + staticOffset
    let wrappedPhase = totalPhase - floor(totalPhase)
    
    // 3. Run it through the waveform math
    let value = wave.waveform.sample(phase: wrappedPhase)
    return CGFloat(wave.amplitude * value)
  }
}

//public struct AnimatedWave {
//  public var wave: Wave
//  public var state: ContinuousParameter
//  //  var state: WaveState
//
//  public init(wave: Wave) {
//    self.wave = wave
//    self.state = ContinuousParameter()
//  }
//}
//
//extension AnimatedWave {
//  
//  public func modulation(
//    currentTime: TimeInterval = Date().timeIntervalSinceReferenceDate,
//    normalisedIndex: CGFloat,
//    cycles: CGFloat
//  ) -> CGFloat {
//    // 1. Get the time-based phase (The "Motor")
//    let tPhase = state.temporalPhase(at: currentTime, frequency: wave.frequency)
//    
//    // 2. Add spatial distribution (The "Coordinates")
//    let sPhase = Double(normalisedIndex * cycles)
//    
//    // 3. Add the static offset (The "Initial Phase")
//    let staticPhase = Double(wave.phase)
//    
//    // Total phase wrapped into [0, 1]
//    let totalPhase = tPhase + sPhase + staticPhase
//    let wrappedPhase = totalPhase - floor(totalPhase)
//    
//    // 4. Sample the waveform
//    let value = wave.waveform.sample(phase: wrappedPhase)
//    return CGFloat(wave.amplitude * value)
//  }
//  
//}
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
//  public func modulation(
//    currentTime: TimeInterval = Date().timeIntervalSinceReferenceDate,
//    normalisedIndex: CGFloat,
//    cycles: CGFloat
//  ) -> CGFloat {
//    let phase = state.effectivePhase(
//      currentTime: currentTime,
//      frequency: wave.frequency
//    )
//    //    let phase = state.effectivePhase(
//    //      currentTime: currentTime,
//    //      normalisedIndex: normalisedIndex,
//    //      cycles: cycles,
//    //      frequency: wave.frequency,
//    //      phaseOffset: wave.phase
//    //    )
//    let value = wave.waveform.sample(phase: phase)
//    return CGFloat(wave.amplitude * value)
//  }

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
//  public func modulation(
//    for wave: any WaveShaped,
//    effectiveTime: TimeInterval,
//    normalisedIndex: CGFloat,
//    cycles: CGFloat
//  ) -> CGFloat {
//
//    let freq = wave.frequency
//    let phase =
//      effectiveTime * wave.frequency  // temporal advance
//      + normalisedIndex * cycles  // spatial distribution
//      + wave.phase  // static offset
//
//    let value = wave.waveform.sample(phase: phase)
//    return wave.amplitude * value
//  }

//}

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
