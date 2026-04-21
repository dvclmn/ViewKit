//
//  WaveSampler.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 29/1/2026.
//

import Accelerate
import CoreGraphics
//import CoreTools
import Darwin
import SwiftUI

public typealias Sampler = WaveSampler<Double>

public enum WaveSampler<T: WaveFloat> {}

extension WaveSampler {
  /// Primary generic entry — callers specify domain and mode.
  @inlinable
  public static func sample(
    _ waveform: Waveform,
    phase: T,
    //    domain: PhaseDomain = .turns,
  ) -> T {
    let pTurns: T = phase
    //    let pTurns: T =
    //      (domain == .turns)
    //      ? Wave.wrapUnit(phase)
    //      : Wave.wrapUnit(phase / T.twoPi)

    switch waveform {
      case .sine(let mode):
        switch mode {
          case .math: return sineMathTurns(pTurns)
          case .table: return sineLookup(pTurns)
        }
      case .triangle: return T(1) - T(4) * abs(pTurns - T(0.5))
      case .sawtooth: return T(2) * pTurns - T(1)
      case .square: return pTurns < T(0.5) ? T(1) : T(-1)
    }
  }
}

extension WaveSampler {
  /// A clear, readable sine for “turns” domain
  @inlinable package static func sineMathTurns(_ phaseTurns: T) -> T {
    T.waveSin(phaseTurns * T.twoPi)
  }
  /// And for radians
  @inlinable package static func sineMathRadians(_ angle: T) -> T {
    T.waveSin(angle)
  }
}

// MARK: - Sine table storage
extension WaveSampler {

  // MARK: Lookup table configuration
  /// Number of bits used to address entries in the sine lookup table.
  /// 11 bits -> 2048 addressable entries (plus one extra for interpolation wrap).
  @usableFromInline
  package static var tableBits: Int { 11 }

  /// Total number of addressable entries in the lookup table (2^tableBits).
  @usableFromInline
  package static var tableSize: Int { 1 << tableBits }

  /// Bitmask for wrapping table indices (e.g., `(index) & tableMask`).
  @usableFromInline
  package static var tableMask: Int { tableSize - 1 }

  /// Table size as a generic floating-point value.
  @usableFromInline
  package static var tableSizeF: T { T(tableSize) }

  @inlinable
  package static func sineLookup(_ phase: T) -> T {
    let tableSize = 1 << 11
    let mask = tableSize - 1
    //    let isFloat = T.self == Float.self
    //        let table = isFloat ? FloatSineTable.table : DoubleSineTable.table
    guard T.self == Float.self else {
      let table = DoubleSineTable.table
      let scaled = Double(phase) * Double(tableSize)
      let i = Int(floor(max(0, scaled)))
      let frac = scaled - Double(i)
      let i0 = i & mask
      let i1 = (i0 + 1) & mask
      let y0 = table[i0]
      let y1 = table[i1]
      return T(y0 + frac * (y1 - y0))
    }
    let table = FloatSineTable.table
    let scaled = Float(phase) * Float(tableSize)
    let i = Int(floor(max(0, scaled)))
    let frac = scaled - Float(i)
    let i0 = i & mask
    let i1 = (i0 + 1) & mask
    let y0 = table[i0]
    let y1 = table[i1]
    return T(y0 + frac * (y1 - y0))

  }
}

@usableFromInline
package struct DoubleSineTable {
  @usableFromInline
  static let table: [Double] = Self.build()

  private static func build() -> [Double] {
    let tableSize = 1 << 11
    var table: [Double] = []
    table.reserveCapacity(tableSize + 1)
    let twoPi = Double.pi * 2
    for i in 0...tableSize {
      let angle = Double(i) * twoPi / Double(tableSize)
      table.append(sin(angle))
    }
    return table
  }
}
@usableFromInline
package struct FloatSineTable {
  @usableFromInline
  static let table: [Float] = Self.build()

  private static func build() -> [Float] {
    let tableSize = 1 << 11
    var table: [Float] = []
    table.reserveCapacity(tableSize + 1)
    let twoPi = Float.pi * 2
    for i in 0...tableSize {
      let angle = Float(i) * twoPi / Float(tableSize)
      table.append(sinf(angle))
    }
    return table
  }
}

//extension WaveSampler {
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
//  @inlinable
//  public static func value(
//    for waveform: Waveform,
//    at phase: T
//  ) -> T {
//    let p = Wave.wrapUnit(phase)
//    return value(for: waveform, phaseRadians: p)
//  }
//
//  /// `phaseRadians` must already be wrapped to 2π radians
//  @inlinable
//  public static func value(
//    for waveform: Waveform,
//    phaseRadians: T
//  ) -> T {
//    let p = phaseRadians
//
//    return switch waveform {
//      case .sine: sineLookup(p)
//
//      /// Standard: `-1 → 1 → -1`, peaks at `0.25` and `0.75`
//      case .triangle: T(1) - T(4) * abs(p - T(0.5))
//
//      /// Linear ramp: `-1 → 1`, discontinuity at integers
//      case .sawtooth: T(2) * p - T(1)
//      case .square: p < T(0.5) ? T(1) : T(-1)
//    }
//  }
//}
