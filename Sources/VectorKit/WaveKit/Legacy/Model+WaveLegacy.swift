//
//  Model+Wave.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 19/8/2025.
//

import CoreTools
import GameplayKit
//import MetaCodable
import SwiftUI

//public protocol WaveBase: Sendable, Codable, Equatable, Hashable {
//  associatedtype Colour: CodableColour
//}

/// The advantages of this “elapsed-only” engine:
/// - Waves are fully self-contained: frequency, amplitude,
///   and phase offset are all local.
/// - No need for global phase wrapping: just pass elapsed time forward.
/// - Flexibility: if you later add modulation (e.g. frequency envelopes),
///   it’s easy because each wave already computes its own phase internally.

//
/// The user has the choice to either specify a per-Wave
/// cycles value here, or there is also a global setting
/// if they are happy to keep it the same for all Waves.

//public struct WaveLegacy: Sendable, Identifiable, Hashable {
//
//  public let id: UUID
//
//  public var frequencySmoothed: SmoothedProperty
//  public var amplitudeSmoothed: SmoothedProperty
//  public var phaseOffsetSmoothed: SmoothedProperty
//  public var noiseSmoothed: SmoothedProperty
//
//  public init(
//    id: UUID = UUID(),
//    frequency: CGFloat,
//    amplitude: CGFloat,
//    phaseOffset: CGFloat = 0,
//    noise: CGFloat = 0
//  ) {
//    self.id = id
//    self.frequencySmoothed = SmoothedProperty(frequency)
//    self.amplitudeSmoothed = SmoothedProperty(amplitude)
//    self.phaseOffsetSmoothed = SmoothedProperty(phaseOffset)
//    self.noiseSmoothed = SmoothedProperty(noise)
//  }
//}
//
//extension WaveLegacy {
//
//  public var frequency: CGFloat { frequencySmoothed.target }
//  public var amplitude: CGFloat { amplitudeSmoothed.target }
//  public var phaseOffset: CGFloat { phaseOffsetSmoothed.target }
//  public var noise: CGFloat { noiseSmoothed.target }
//
//  public var omega: CGFloat { frequency.omega }
//
//  private func phase(elapsed: CGFloat) -> CGFloat {
//    omega * elapsed + phaseOffset
//  }
//
//  /// Smooth parameters towards target each tick
//  public mutating func updateProperties(dt: CGFloat, smoothing: CGFloat) {
//    frequencySmoothed.update(dt: dt, smoothing: smoothing)
//    amplitudeSmoothed.update(dt: dt, smoothing: smoothing)
//    phaseOffsetSmoothed.update(dt: dt, smoothing: smoothing)
//    noiseSmoothed.update(dt: dt, smoothing: smoothing)
//  }
//
//  /// Evaluate wave value at given elapsed time (seconds since start)
//  public func value(elapsed: CGFloat) -> CGFloat {
//    let phase = self.phase(elapsed: elapsed)
//    let sinPhase = sin(phase)
//    return amplitude * sinPhase
//  }
//
//  private static var validRange: ClosedRange<CGFloat> { -1...1 }
//
//}
