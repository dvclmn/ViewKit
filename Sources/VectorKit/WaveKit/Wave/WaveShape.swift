//
//  WaveShape.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 22/1/2026.
//

import Foundation

public protocol WaveShaped {
  var frequency: Double { get }
  var amplitude: Double { get }
  var phase: Double { get }
}

extension WaveShaped {
  /// Compute the modulation value given the current time and a normalised index
  /// E.g if your property should vary by a sine wave that travels
  /// over time while also spanning a fixed number of cycles over your circles,
  /// you can use this value directly.
  public func modulation(
    effectiveTime: TimeInterval,
    normalisedIndex: Double,
    cycles: Double
  ) -> CGFloat {
    let argument =
      effectiveTime
      * frequency
      + normalisedIndex
      * cycles.omega
      + phase

    let sine = sin(argument)
    return amplitude * sine
  }
}
