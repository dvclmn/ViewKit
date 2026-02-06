//
//  WaveSampler.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 29/1/2026.
//

import Accelerate
import CoreGraphics
import CoreTools
import Darwin
import Foundation
import SwiftUI

public typealias Sampler = WaveSampler<Double>
//public typealias Sampler = WaveSampler<Float>

/// Uses `Float` internally
///
/// Good for scalar calls — fast and predictable
/// ```
/// let y = WaveSampler<Float>.value(for: .sine, at: phase)
/// ```
///
/// Good for arrays — vForce is very fast here
/// ```
/// let ys = WaveSampler<Float>.values(for: .sine, phases: phaseArray)
/// ```
public enum WaveSampler<T: WaveFloat> {}

extension WaveSampler {
  /// Note: Scalar calls: Calling sin repeatedly per-sample can be relatively expensive.
  /// A lookup table with linear interpolation is extremely fast for single-sample access.
  /// So for scalar sampling (one value(for:at:) at a time), this use of `sineTable`
  /// is often faster and predictable.
  ///
  /// Returns the waveform value for a given phase in turns.
  /// - Parameters:
  ///   - waveform: The waveform shape to sample.
  ///   - phase: A phase value in arbitrary units; it will be normalized to [0, 1).
  ///            Interpret 1.0 as one full turn (2π radians). Values outside [0, 1)
  ///            are wrapped safely before lookup.
  /// - Returns: The waveform sample in the range [-1, 1].
  @inlinable
  public static func value(
    for waveform: Waveform,
    at phase: T
  ) -> T {
    let p = Wave.wrapUnit(phase)
    return value(for: waveform, phaseRadians: p)
  }

  /// `phaseRadians` must already be wrapped to 2π radians
  @inlinable
  public static func value(
    for waveform: Waveform,
    phaseRadians: T
  ) -> T {
    let p = phaseRadians

    return switch waveform {
      case .sine: sineLookup(p)

      /// Standard: `-1 → 1 → -1`, peaks at `0.25` and `0.75`
      case .triangle: T(1) - T(4) * abs(p - T(0.5))

      /// Linear ramp: `-1 → 1`, discontinuity at integers
      case .sawtooth: T(2) * p - T(1)
      case .square: p < T(0.5) ? T(1) : T(-1)
    }
  }
}

// MARK: - Sine table storage
extension WaveSampler {

  // MARK: Lookup table configuration
  /// Number of bits used to address entries in the sine lookup table.
  /// 11 bits -> 2048 addressable entries (plus one extra for interpolation wrap).
  @usableFromInline static var tableBits: Int { 11 }

  /// Total number of addressable entries in the lookup table (2^tableBits).
  @usableFromInline static var tableSize: Int { 1 << tableBits }

  /// Bitmask for wrapping table indices (e.g., `(index) & tableMask`).
  @usableFromInline static var tableMask: Int { tableSize - 1 }

  /// Table size as a generic floating-point value.
  @usableFromInline static var tableSizeF: T { T(tableSize) }

  /// Lazily computed sine lookup table with an extra sample for linear interpolation.
  /// The extra element duplicates the first to simplify wrap-around.
  @usableFromInline static var sineTable: [T] {
    /// Build once per generic instantiation `T`
    var table = [T]()
    table.reserveCapacity(tableSize + 1)
    let twoPi: T = T(2) * T.pi
    let denom = tableSizeF

    /// Explicitly lift `i` to `T` to avoid integer/generic arithmetic ambiguity.
    for i in 0...tableSize {
      let angle: T = (T(i) * twoPi) / denom
      let sinAngle = T.waveSin(angle)
      table.append(sinAngle)
    }
    return table
  }
  @inlinable
  static func sineLookup(_ phase: T) -> T {
    /// Scale phase in [0, 1) to table space and split into integer/fractional parts.
    let scaled = phase * tableSizeF
    let index = Int(floor(max(T(0), scaled)))
    let fraction = scaled - T(index)

    let i0 = index & tableMask
    let i1 = (i0 + 1) & tableMask

    /// Linear interpolation between neighbors
    let y0 = sineTable[i0]
    let y1 = sineTable[i1]
    return y0 + fraction * (y1 - y0)
  }
}
