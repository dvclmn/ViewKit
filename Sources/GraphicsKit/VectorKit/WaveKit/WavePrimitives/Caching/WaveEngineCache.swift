//
//  WaveSpatialCache.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 28/1/2026.
//

import SwiftUI

/// I haven't vigorously inspected this, to determine if anything useful here
@Observable
final class WaveformEngine {
  // Inputs
  private var frequency: CGFloat = 0
  private var amplitude: CGFloat = 0
  private var phase: CGFloat = 0
  private var samples: Int = 0
  
  // Cache
  private var cachedSignature: Signature?
  private var cachedPath: Path?
  
  func updateInputs(frequency: CGFloat, amplitude: CGFloat, phase: CGFloat, samples: Int) {
    self.frequency = frequency
    self.amplitude = amplitude
    self.phase = phase
    self.samples = samples
    // Don’t invalidate immediately; defer until asked for a path with a size.
  }
  
  func path(for size: CGSize) -> Path? {
    let sig = Signature(
      frequency: frequency,
      amplitude: amplitude,
      phase: phase,
      samples: samples,
      width: size.width,
      height: size.height
    )
    
    if sig == cachedSignature, let path = cachedPath {
      return path
    }
    
    let path = buildWavePath(
      size: size,
      frequency: frequency,
      amplitude: amplitude,
      phase: phase,
      samples: samples)
    
    cachedSignature = sig
    cachedPath = path
    return path
  }
  
  private func buildWavePath(
    size: CGSize,
    frequency: CGFloat,
    amplitude: CGFloat,
    phase: CGFloat,
    samples: Int
  ) -> Path {
    var p = Path()
    guard samples > 1 else { return p }
    
    let midY = size.height / 2
    let stepX = size.width / CGFloat(samples - 1)
    let twoPiF = 2 * .pi * frequency
    
    var x: CGFloat = 0
    for i in 0..<samples {
      let t = CGFloat(i) / CGFloat(samples - 1)
      let y = midY + sin(twoPiF * t + phase) * amplitude
      if i == 0 {
        p.move(to: CGPoint(x: x, y: y))
      } else {
        p.addLine(to: CGPoint(x: x, y: y))
      }
      x += stepX
    }
    return p
  }
  
  private struct Signature: Equatable {
    var frequency: CGFloat
    var amplitude: CGFloat
    var phase: CGFloat
    var samples: Int
    var width: CGFloat
    var height: CGFloat
  }
}
