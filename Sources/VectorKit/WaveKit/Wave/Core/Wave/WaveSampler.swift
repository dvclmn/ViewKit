//
//  WaveSampler.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 29/1/2026.
//

import Accelerate
import Foundation
import SwiftUI

//public enum Waveform: CaseIterable {
//  case sine, triangle, sawtooth, square
//}

// MARK: - Phase Handling
@inlinable
func normalizedPhase(_ phase: Float) -> Float {
  // Corrects negative phases and floating-point overflow
  let p = phase - floor(phase)
  // Clamp 1.0 to 0.0 (rare, but possible with floating point error)
  return p >= 1.0 ? 0 : p
}

// MARK: - High-Performance Sampler
public struct FastWaveSampler {
  @usableFromInline static let tableBits = 11  // 2048 entries
  @usableFromInline static let tableSize = 1 << tableBits  // 2048
  @usableFromInline static let tableMask = tableSize - 1
  @usableFromInline static let tableSizeF = Float(tableSize)

  // Linearly interpolated sine table (better than nearest-neighbor)
  @usableFromInline static let sineTable: [Float] = (0...tableSize).map { i in
    sin(Float(i) * 2 * .pi / tableSizeF)
  }

  /// Single value evaluation (useful for markers or specific points)
  @inlinable
  public static func value(for waveform: Waveform, at phase: Float) -> Float {
    let p = normalizedPhase(phase)

    switch waveform {
      case .sine:
        return sineLookup(p)
      case .triangle:
        // Standard: -1 → 1 → -1, peaks at 0.25 and 0.75
        return 1.0 - 4.0 * abs(p - 0.5)
      case .sawtooth:
        // Linear ramp: -1 → 1, discontinuity at integers
        return 2.0 * p - 1.0
      case .square:
        return p < 0.5 ? 1.0 : -1.0
    }
  }

  /// Vectorized evaluation for Canvas paths (huge performance win)
  public static func values(
    for waveform: Waveform,
    phases: [Float]
  ) -> [Float] {
    var result = [Float](repeating: 0, count: phases.count)

    switch waveform {
      case .sine:
        /// Use Accelerate for true vectorized sin (faster than lookup tables on modern chips)
        var scaled = [Float](repeating: 0, count: phases.count)
        let twoPi: Float = 2.0 * .pi
        vDSP.multiply(twoPi, phases, result: &scaled)
        vForce.sin(scaled, result: &result)

      default:
        // For geometric waves, manual SIMD or simple map is fastest
        // (could also use vDSP for the triangle/sawtooth math)
        for i in phases.indices {
          result[i] = value(for: waveform, at: phases[i])
        }
    }

    return result
  }

  @inlinable
  static func sineLookup(_ phase: Float) -> Float {
    let scaled = phase * tableSizeF
    let index = Int(scaled)
    let fraction = scaled - Float(index)

    let i0 = index & tableMask
    let i1 = (i0 + 1) & tableMask

    // Linear interpolation between neighbors
    let y0 = sineTable[i0]
    let y1 = sineTable[i1]
    return y0 + fraction * (y1 - y0)
  }
}

// MARK: - Phase Accumulator (for smooth animation)
public struct WavePhaseAccumulator {
  private var phase: Float = 0
  public var frequency: Float
  public var sampleRate: Float  // For time-based animation, use display link FPS

  public init(frequency: Float, sampleRate: Float = 60) {
    self.frequency = frequency
    self.sampleRate = sampleRate
  }

  /// Call every frame to get progressive phase (avoids floating-point drift from large time values)
  public mutating func advance() -> Float {
    phase += frequency / sampleRate
    if phase > 1_000_000 {  // Reset to prevent precision loss over long animations
      phase = normalizedPhase(phase)
    }
    return phase
  }

  public mutating func reset() {
    phase = 0
  }
}

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
