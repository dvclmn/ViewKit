//
//  PhaseComponents.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 12/2/2026.
//

import Foundation

public struct PhaseComponents {

  /// Current oscillation phase based on time
  /// `2π * f * t`
  let timePhaseRadians: Double

  /// Cycles. Number of cycles across index 0…1 in turns
  let spatialCycles: Double  //

  /// Phase offset, in radians
  let staticPhaseRadians: Double

  @inline(__always)
  public func radians(for index: Double) -> Double {
    timePhaseRadians + (spatialCycles * .twoPi * index) + staticPhaseRadians
  }

  @inline(__always)
  public func turns(for index: Double) -> Double {

    /// Convert radians to turns for the temporal/static parts, then add spatial turns.
    let temporalTurns = timePhaseRadians / .twoPi
    let staticTurns = staticPhaseRadians / .twoPi
    let total = temporalTurns + (spatialCycles * index) + staticTurns
    return total - floor(total)  // wrap to [0, 1)
  }
}

extension PhaseComponents {
  public init(
    from wave: ConfiguredWave,
    index: Double,
    elapsedTime: TimeInterval
  ) {
    let timePhase = .twoPi * wave.frequency * elapsedTime
    let spatial = Double(wave.config.cycles)  // In “turns”
    let staticPhase = wave.phaseRadians
    self.init(timePhaseRadians: timePhase, spatialCycles: spatial, staticPhaseRadians: staticPhase)
  }
}

//struct PhaseInput {
//  let index: Double  // spatial parameter in 0...1
//  let cycles: Double  // spatial cycles across the span
//  let timePhase: Double  // ωt or any time-driven phase
//  let staticPhase: Double  // per-wave phase offset
//
//  init(
//    index: Double,
//    cycles: Double,
//    timePhase: Double,
//    staticPhase: Double
//  ) {
//    self.index = index
//    self.cycles = cycles
//    self.timePhase = timePhase
//    self.staticPhase = staticPhase
//  }
//}
//extension PhaseInput {
//  @inline(__always)
//  func combinedPhase() -> Double {
//    let spatial = index * cycles * twoPi()
//    return timePhase + spatial + staticPhase
//  }
//
//}
//
//extension PhaseInput {
//  init(
//    from channel: WaveChannel,
//    index: Double,
//    elapsedTime: TimeInterval,
//  ) {
//    self.init(
//      index: index,
//      cycles: channel.wave.config.cycles,
//      timePhase: channel.timePhase(from: elapsedTime),
//      staticPhase: channel.wave.phaseRadians
//    )
//  }
//}
