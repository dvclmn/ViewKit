//
//  ExampleCachedView.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 5/2/2026.
//

import SwiftUI

struct WaveformCanvas: View {
  @State private var engine = WaveformEngine()
  
  // Tweak these to taste:
  private let radiansPerSecond: CGFloat = 2.0  // angular speed
  private let phaseQuantization: CGFloat = 0.1  // radians; higher = more caching, less fluid
  
  var body: some View {
    TimelineView(.animation) { context in
      // Compute a time-based phase from TimelineView's date
      let t = CGFloat(context.date.timeIntervalSinceReferenceDate)
      let phase = t * radiansPerSecond
      
      // Quantize the phase to reduce cache churn while keeping motion smooth
      let quantizedPhase = (phase / phaseQuantization).rounded() * phaseQuantization
      
      
      Canvas { context, size in
        if let path = engine.path(for: size) {
          context.stroke(path, with: .color(.cyan), lineWidth: 2)
        }
      }
      .task(id: context.date.timeIntervalSinceReferenceDate) {
        // Update inputs for this tick
        engine.updateInputs(
          frequency: 4.0,
          amplitude: 80,
          phase: quantizedPhase,
          samples: 1024
        )
        
      }
    }
  }
}
