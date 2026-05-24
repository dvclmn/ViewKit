//
//  PhaseComponents.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 12/2/2026.
//

import CoreTools
//import Foundation
//
//public struct PhaseComponents {
//  let index: Double  // spatial parameter in 0...1
//  let cycles: Double  // spatial cycles across the span
//  let timePhase: Double  // ωt or any time-driven phase
//  let staticPhase: Double  // per-wave phase offset
//
//  public init(
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
//
//extension PhaseComponents {
//  public init(
//    from wave: ConfiguredWave,
//    index: Double,
//    elapsedTime: TimeInterval,
//  ) {
//    self.init(
//      index: index,
//      cycles: wave.config.cycles,
//      timePhase: wave.timePhase(from: elapsedTime),
//      staticPhase: wave.wave.unitPhase
//    )
//  }
//  @inline(__always)
//  public func combinedPhase() -> Double {
//    let spatial = index * cycles * twoPi()
//    return timePhase + spatial + staticPhase
//  }
//}

//public struct PhaseComponents {
//
//    /// Current oscillation phase based on time
//  let timeUnitPhase: Double
////  /// `2π * f * t`
////  let timePhaseRadians: Double
//
//  /// Cycles. Number of cycles across index 0…1 in turns
//  let spatialCycles: Double  //
//
//  let phaseTurns: Double // Offset
////  /// Phase offset, in radians
////  let staticPhaseRadians: Double
//
//  public init(
//    timePhase: Double,
////    timePhaseRadians: Double,
//    cycles: Double,
//    staticPhaseRadians: Double
//  ) {
//    self.timePhaseRadians = timePhaseRadians
//    self.spatialCycles = spatialCycles
//    self.staticPhaseRadians = staticPhaseRadians
//  }
//}
//
//extension PhaseComponents {
//
//  @inline(__always)
//  public func radians(for index: Double) -> Double {
//    timePhaseRadians + (spatialCycles * .twoPi * index) + staticPhaseRadians
//  }
//
//  @inline(__always)
//  public func turns(for index: Double) -> Double {
//
//    /// Convert radians to turns for the temporal/static parts, then add spatial turns.
//    let temporalTurns = timePhaseRadians / .twoPi
//    let staticTurns = staticPhaseRadians / .twoPi
//    let total = temporalTurns + (spatialCycles * index) + staticTurns
//    return total - floor(total)  // wrap to [0, 1)
//  }
//}
//
//
//  public init(
//    from wave: ConfiguredWave,
//    index: Double,
//    elapsedTime: TimeInterval
//  ) {
//    let timePhase = .twoPi * wave.frequency * elapsedTime
//    let spatial = Double(wave.config.cycles)  // In “turns”
//    let staticPhase = wave.phaseRadians
//    self.init(timePhaseRadians: timePhase, spatialCycles: spatial, staticPhaseRadians: staticPhase)
//  }
//}
