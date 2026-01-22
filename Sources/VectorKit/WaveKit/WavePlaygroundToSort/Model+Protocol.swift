//
//  Model+Protocol.swift
//  AnimationPlayground
//
//  Created by Dave Coleman on 1/2/2025.
//

import Foundation

public struct WaveModulator: Sendable, Codable {
 let isEnable: Bool
  let cycles: Double
  let wave: Wave
  
}
//  let isEnabled: Bool
//  let amplitude: CGFloat
//  let frequency: CGFloat  // Aka speed
//
//  /// In radians
//  let phase: CGFloat
//
//  /// How many cycles (periods) should be laid out in the View
//  /// E.g.  the normalised index running from 0 to 1.
//  let cycles: CGFloat
//
//  public init(
//    isEnabled: Bool,
//    amp: CGFloat = 0.8,
//    freq: CGFloat = 0.3,
//    phase: CGFloat = 1.0,
//    cycles: CGFloat = 6.0,
//  ) {
//    self.isEnabled = isEnabled
//    self.amplitude = amp
//    self.frequency = freq
//    self.phase = phase
//    self.cycles = cycles
//  }
//}
