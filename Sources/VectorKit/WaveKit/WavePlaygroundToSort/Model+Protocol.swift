//
//  Model+Protocol.swift
//  AnimationPlayground
//
//  Created by Dave Coleman on 1/2/2025.
//

import Foundation

public protocol WaveAnimatable: Codable, Sendable {

  var isEnabled: Bool { get }
  var amplitude: CGFloat { get }
  var speed: CGFloat { get }

  /// In radians
  var phase: CGFloat { get }

  /// How many cycles (periods) should be laid out in the View
  /// E.g.  the normalised index running from 0 to 1.
  var cycles: CGFloat { get }

  /// Compute the modulation value given the current time and a normalised index
  /// E.g if your property should vary by a sine wave that travels
  /// over time while also spanning a fixed number of cycles over your circles,
  /// you can use this value directly.
  func modulation(effectiveTime: TimeInterval, normalisedIndex: CGFloat) -> CGFloat
}

extension WaveAnimatable {
  public func modulation(
    effectiveTime: TimeInterval,
    normalisedIndex: CGFloat
  ) -> CGFloat {
    guard isEnabled else { return 0 }

    let omega = cycles.omega
    let argument = effectiveTime * speed + normalisedIndex * omega
    let phaseAdded = argument + phase
    let sine = sin(argument)
    return amplitude * sine
  }
}

public struct WaveModulator: WaveAnimatable, Codable {
  public var isEnabled: Bool
  public var amplitude: CGFloat
  public var speed: CGFloat
  public var phase: CGFloat
  public var cycles: CGFloat
}
