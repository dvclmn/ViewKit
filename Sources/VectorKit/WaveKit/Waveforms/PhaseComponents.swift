//
//  PhaseComponents.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 12/2/2026.
//

import Foundation

struct PhaseComponents {
  let timePhaseRadians: Double      // 2π * f * t
  let spatialCycles: Double         // number of cycles across index 0…1 (in turns)
  let staticPhaseRadians: Double    // phase offset in radians
  
  @inline(__always)
  func radians(for index: Double) -> Double {
    timePhaseRadians + (spatialCycles * .twoPi * index) + staticPhaseRadians
  }
  
  @inline(__always)
  func turns(for index: Double) -> Double {
    // Convert radians to turns for the temporal/static parts, then add spatial turns.
    let temporalTurns = timePhaseRadians / .twoPi
    let staticTurns = staticPhaseRadians / .twoPi
    let total = temporalTurns + (spatialCycles * index) + staticTurns
    return total - floor(total) // wrap to [0, 1)
  }
}

extension PhaseComponents {
  init(from channel: WaveChannel, index: Double, elapsedTime: TimeInterval) {
    let timePhase = .twoPi * channel.wave.frequency * elapsedTime
    let spatial = Double(channel.wave.config.cycles) // In “turns”
    let staticPhase = channel.wave.phaseRadians
    self.init(timePhaseRadians: timePhase, spatialCycles: spatial, staticPhaseRadians: staticPhase)
  }
}

struct PhaseInput {
  let index: Double  // spatial parameter in 0...1
  let cycles: Double  // spatial cycles across the span
  let timePhase: Double  // ωt or any time-driven phase
  let staticPhase: Double  // per-wave phase offset
  
  init(
    index: Double,
    cycles: Double,
    timePhase: Double,
    staticPhase: Double
  ) {
    self.index = index
    self.cycles = cycles
    self.timePhase = timePhase
    self.staticPhase = staticPhase
  }
}
extension PhaseInput {
  @inline(__always)
  func combinedPhase() -> Double {
    let spatial = index * cycles * twoPi()
    return timePhase + spatial + staticPhase
  }
  
}

extension PhaseInput {
  init(
    from channel: WaveChannel,
    index: Double,
    elapsedTime: TimeInterval,
  ) {
    self.init(
      index: index,
      cycles: channel.wave.config.cycles,
      timePhase: channel.timePhase(from: elapsedTime),
      staticPhase: channel.wave.phaseRadians
    )
  }
}
