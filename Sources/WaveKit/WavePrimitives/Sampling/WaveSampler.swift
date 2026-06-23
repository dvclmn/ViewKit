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
//import SwiftUI

public typealias Sampler = WaveSampler<Double>

public enum WaveSampler<T: WaveFloat> {}

extension WaveSampler {
  /// Samples a waveform at a normalised phase, before amplitude or visual
  /// mapping is applied.
  ///
  /// The returned unit value is in `-1...1`. Discontinuous waveforms use the
  /// following boundary policy:
  /// - Square changes from `1` to `-1` at half a turn.
  /// - Sawtooth wraps from its upper limit back to `-1` at a whole turn.
  @inlinable
  public static func sample(
    _ waveform: Waveform,
    phase: UnitPhase<T>
  ) -> T {
    let pTurns = phase.turns

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

  /// Samples a waveform from a phase expressed in turns.
  ///
  /// This overload preserves the existing scalar API while making the
  /// ``UnitPhase`` overload the authoritative implementation.
  @inlinable
  public static func sample(
    _ waveform: Waveform,
    phase: T
  ) -> T {
    sample(waveform, phase: UnitPhase(phase))
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
