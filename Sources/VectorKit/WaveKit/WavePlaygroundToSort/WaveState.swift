//
//  Model+WaveState.swift
//  AnimationVisualiser
//
//  Created by Dave Coleman on 10/11/2024.
//

import Foundation


//extension WaveState: CustomStringConvertible {
//  public var description: String {
//    "WaveState(Current phase: \(currentPhase), Last update: \(lastUpdate?.description ?? "nil"), Combined value: \(combinedWaveValue))"
//  }
//}
//
///// Runtime state for a wave
//struct WaveState: Equatable, Sendable {
//  var currentPhase: Double = 0.0
//  var lastUpdate: Date? = nil
//  var combinedWaveValue: Double = 0.0
//  
//  static let `default`: WaveState = .init()
//  
//  @inlinable mutating func update(
//    configuration: WaveConfiguration,
//    currentDate: Date
//  ) {
//    
////    print("\n\nUpdating wave state, with configuration: \(configuration) at \(currentDate)\n\n")
//
//    /// Calculate how much the phase should advance based on time passed
//    /// - `2π` (`2 * .pi`) represents one complete cycle of the sine wave
//    /// - `frequency` determines how many cycles per second
//    /// - `deltaTime * frequency` gives us how many cycles to advance
//    /// - multiplying by `2π` converts cycles to radians
//    ///
//    let deltaTime = lastUpdate.map { currentDate.timeIntervalSince($0) } ?? 0
//
//    let deltaPhase = 2 * .pi * configuration.frequency * deltaTime
//    
//    /// Update the current phase, keeping it within [0, 2π]
//    /// This wrapping ensures smooth looping animation
//    ///
//    currentPhase = (currentPhase + deltaPhase).truncatingRemainder(dividingBy: 2 * Double.pi)
//    
//    /// Apparently removing this line `lastUpdate = currentDate`
//    /// causes the entire animation not to animate, at all.
//    lastUpdate = currentDate
//    
//    /// Calculate the basic sine wave value (-1 to 1)
//    /// `parameters.phase` allows offsetting the starting position — useful for
//    /// adjusting timing relative to other properties
//    ///
//    let baseValue = sin(currentPhase + configuration.phase)
//    let noiseValue = configuration.noise.finalValue
//    
//    /// Combine base wave with noise and scale by `amplitude`
//    /// `amplitude` determines how far the wave moves from center
//    ///
//    combinedWaveValue = (baseValue + noiseValue) * configuration.amplitude
//    
////    print("Final combined value: \(combinedWaveValue)")
//  }
//
//  func applying(_ mutation: (inout WaveState) -> Void) -> WaveState {
//    var copy = self
//    mutation(&copy)
//    return copy
//  }
//  
//  
//}
