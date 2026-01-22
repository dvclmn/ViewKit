//
//  WaveShape.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 22/1/2026.
//

import Foundation

/// **Phase** – where am I in the cycle? (radians)
/// **Waveform** – how does value map to phase?
/// **Frequency** – how fast phase advances
/// **Amplitude** – how large the output is
/// **Domain** – what variable drives phase (time, space, index)
public protocol WaveShaped {
  var frequency: Double { get }
  var amplitude: Double { get }
  var phase: Double { get }  // phase offset, in cycles
  var waveform: Waveform { get }
}

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

extension WaveShaped {
  /// Compute the modulation value given the current time and a normalised index
  /// E.g if your property should vary by a sine wave that travels
  /// over time while also spanning a fixed number of cycles over your circles,
  /// you can use this value directly.
  ///
  /// ## More on `normalisedIndex`
  /// It is not time — it is space (or structure).
  ///
  /// Multiplying it by cycles answers this:
  /// "Across this domain, how many full oscillations should exist?"
  ///
  /// Depending on context, a `normalisedIndex` could be:
  /// - the index of a circle in a row of circles
  /// - the x-position of a point across a width
  /// - the progress along a path
  /// - a radial distance normalised to a maximum
  /// - a vertex index in a mesh
  ///
  /// - Parameters:
  ///   - effectiveTime: A consistent elapsed time value
  ///   - normalisedIndex: A position along some domain, scaled into [0, 1]
  ///   - cycles: <#cycles description#>
  /// - Returns: <#description#>
  ///

  
  
  public func modulation(
    effectiveTime: TimeInterval,
    normalisedIndex: Double,
    cycles: Double
  ) -> CGFloat {

    let phase =
      effectiveTime * frequency  // temporal advance
      + normalisedIndex * cycles  // spatial distribution
      + self.phase  // static offset

    let value = waveform.sample(phase: phase)
    return amplitude * value
  }
  //  public func modulation(
  //    effectiveTime: TimeInterval,
  //    normalisedIndex: Double,
  //    cycles: Double
  //  ) -> CGFloat {
  //
  //    /// temporal phase (`effectiveTime * frequency`)
  //    /// spatial phase (`normalisedIndex * cycles`)
  //    /// static offset (`phase`)
  //    let argument =
  //      effectiveTime
  //      * frequency
  //      + normalisedIndex
  //      * cycles.omega
  //      + phase
  //
  //    let sine = sin(argument)
  //    return amplitude * sine
  //  }
}
