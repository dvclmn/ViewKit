//
//  WaveAdjuster.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 21/1/2026.
//

import Foundation

public typealias ContinuousFloat = ContinuousParameter<Double>
//public typealias ContinuousFloat = ContinuousParameter<Float>

/// `Result = (CurrentTime – Origin) * Rate + Offset`
/// Manages a value that evolves over time (like phase or rotation)
/// and ensures transitions between different rates/offsets are seamless.
/// Domain‑specific to oscillation.
/// Look to this now instead of `WaveAttributeState`
public struct ContinuousParameter<T: WaveFloat> {
  private var lastSyncTime: TimeInterval = 0
  private var accumulatedPhase: T = 0

  public init() {}

  /// Call this once per frame (main thread). Use `frequency` for integration.
  public mutating func update(at now: TimeInterval, frequency: T) {
    if lastSyncTime == 0 { lastSyncTime = now }
    let deltaTime = now - lastSyncTime
    accumulatedPhase += T(deltaTime) * frequency
    lastSyncTime = now
  }

  /// Normalised phase in cycles [0,1).
  public var currentPhase: T {
    accumulatedPhase - floor(accumulatedPhase)
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
