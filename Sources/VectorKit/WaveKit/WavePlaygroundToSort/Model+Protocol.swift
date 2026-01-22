//
//  Model+Protocol.swift
//  AnimationPlayground
//
//  Created by Dave Coleman on 1/2/2025.
//

import Foundation

public struct WaveModulator: Sendable, Codable {
  let isEnabled: Bool
  let amplitude: CGFloat
  let frequency: CGFloat  // Aka speed

  /// In radians
  let phase: CGFloat

  /// How many cycles (periods) should be laid out in the View
  /// E.g.  the normalised index running from 0 to 1.
  let cycles: CGFloat

  public init(
    isEnabled: Bool,
    amp: CGFloat = 0.8,
    freq: CGFloat = 0.3,
    phase: CGFloat = 1.0,
    cycles: CGFloat = 6.0,
  ) {
    self.isEnabled = isEnabled
    self.amplitude = amp
    self.frequency = freq
    self.phase = phase
    self.cycles = cycles
  }

}

extension WaveModulator {
  /// Compute the modulation value given the current time and a normalised index
  /// E.g if your property should vary by a sine wave that travels
  /// over time while also spanning a fixed number of cycles over your circles,
  /// you can use this value directly.
  public func modulation(
    effectiveTime: TimeInterval,
    normalisedIndex: CGFloat
  ) -> CGFloat {
    guard isEnabled else { return 0 }

    let omega = cycles.omega
    let argument = effectiveTime * frequency + normalisedIndex * omega
    let phaseAdded = argument + phase
    let sine = sin(argument)
    return amplitude * sine
  }
}
