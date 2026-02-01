//
//  WaveSampler.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 29/1/2026.
//

import Accelerate
import CoreTools
import Foundation
import SwiftUI
import Darwin

// MARK: - High-Performance Sampler
public struct WaveSampler<T: WaveFloat> {
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

  // MARK: Sine table storage
  /// Lazily computed sine lookup table with an extra sample for linear interpolation.
  /// The extra element duplicates the first to simplify wrap-around.
  @usableFromInline static var sineTable: [T] {
    // Build once per generic instantiation `T`.
    var table = [T]()
    table.reserveCapacity(tableSize + 1)
    let twoPi = T(2) * .pi
    let denom = tableSizeF
    for i in 0...tableSize { // inclusive to add the wrap sample
      // Explicitly lift `i` to `T` to avoid integer/generic arithmetic ambiguity.
      let angle = (T(i) * twoPi) / denom
      let sinAngle = 
      table.append(sinAngle)
    }
    return table
  }

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
    let p = T.normalisedPhase(phase)

    return switch waveform {
      case .sine: sineLookup(p)
        
      case .triangle:
        // Standard: -1 → 1 → -1, peaks at 0.25 and 0.75
        T(1) - T(4) * abs(p - T(0.5))
      case .sawtooth:
        // Linear ramp: -1 → 1, discontinuity at integers
        T(2) * p - T(1)
      case .square:
        p < T(0.5) ? T(1) : T(-1)
    }
  }

  @inlinable
  static func sineLookup(_ phase: T) -> T {
    // Scale phase in [0, 1) to table space and split into integer/fractional parts.
    let scaled = phase * tableSizeF
    let index = Int(floor(max(T(0), scaled)))
    let fraction = scaled - T(index)

    let i0 = index & tableMask
    let i1 = (i0 + 1) & tableMask

    // Linear interpolation between neighbors
    let y0 = sineTable[i0]
    let y1 = sineTable[i1]
    return y0 + fraction * (y1 - y0)
  }

}

extension WaveSampler where T == Float {
  /// Vectorized evaluation for Canvas paths (huge performance win)
  public static func values(
    for waveform: Waveform,
    phases: [T]
  ) -> [T] {
    var result = [T](repeating: 0, count: phases.count)

    switch waveform {
      case .sine:
        /// Use Accelerate for true vectorized sin (faster than lookup tables on modern chips)
        var scaled = [T](repeating: 0, count: phases.count)
        let twoPi: T = 2.0 * .pi
        vDSP.multiply(twoPi, phases, result: &scaled)
        vForce.sin(scaled, result: &result)

      default:
        /// For geometric waves, manual SIMD or simple map is fastest
        /// (could also use vDSP for the triangle/sawtooth math)
        for i in phases.indices {
          let p = phases[i]
          result[i] = value(for: waveform, at: p)
        }
    }

    return result
  }

}

// MARK: - Phase Accumulator (for smooth animation)
//public struct WavePhaseAccumulator {
//  private var phase: T = 0
//  public var frequency: T
//  public var sampleRate: T  // For time-based animation, use display link FPS
//
//  public init(frequency: T, sampleRate: T = 60) {
//    self.frequency = frequency
//    self.sampleRate = sampleRate
//  }
//
//  /// Call every frame to get progressive phase (avoids floating-point drift from large time values)
//  public mutating func advance() -> T {
//    phase += frequency / sampleRate
//    if phase > 1_000_000 {  // Reset to prevent precision loss over long animations
//      phase = normalisedPhase(phase)
//    }
//    return phase
//  }
//
//  public mutating func reset() {
//    phase = 0
//  }
//}

// MARK: - SwiftUI Canvas Usage
//struct WaveformView: View {
//  @State private var time: TimeInterval = 0
//  let waveform: Waveform = .sine
//  let frequency: Float = 3.0
//
//  var body: some View {
//    TimelineView(.animation(minimumInterval: 1 / 60, paused: false)) { timeline in
//      Canvas { context, size in
//        let width = Float(size.width)
//        let height = Float(size.height)
//        let midY = height / 2
//
//        // Generate phases for x-axis points
//        let steps = Int(size.width)  // One sample per pixel (or use stride for performance)
//        let xValues = (0..<steps).map { Float($0) / width }  // 0...1 across width
//
//        // Time-based phase shift
//        let phaseShift = Float(timeline.date.timeIntervalSinceReferenceDate) * 2.0
//
//        // Vectorized sample generation
//        let phases = xValues.map { $0 * frequency + phaseShift }
//        let samples = FastWaveSampler.values(for: waveform, phases: phases)
//
//        // Build path
//        var path = Path()
//        let startY = CGFloat(midY + samples[0] * midY * 0.8)
//        path.move(to: CGPoint(x: 0, y: startY))
//
//        for (i, sample) in samples.enumerated().dropFirst() {
//          let x = CGFloat(i)
//          let y = CGFloat(midY + sample * midY * 0.8)  // 0.8 amplitude
//          path.addLine(to: CGPoint(x: x, y: y))
//        }
//
//        context.stroke(path, with: .color(.blue), lineWidth: 2)
//      }
//    }
//  }
//}

