//
//  DrawLinePath.swift
//  BaseDemos
//
//  Created by Dave Coleman on 24/1/2026.
//

import SwiftUI

struct LinePathContext {
  let start: CGPoint
  let end: CGPoint
  let style: ActionLine.Style
}

extension LinePathContext {
  private var wavy: Path {
    var path = Path()
    
    let cycles = 2.0
    let amplitude = style.width
    let samples = 40
    let dx = end.x - start.x
    let dy = end.y - start.y
    
    // Create the spine path (centerline of the wave)
    var spinePath = Path()
    let angle = atan2(dy, dx)
    let perp = CGPoint(x: -sin(angle), y: cos(angle))
    
    for i in 0...samples {
      let t = Double(i) / Double(samples)
      let px = start.x + dx * t
      let py = start.y + dy * t
      let wave = sin(t * .pi * 2 * cycles)
      let wx = px + perp.x * wave * amplitude
      let wy = py + perp.y * wave * amplitude
      let pt = CGPoint(x: wx, y: wy)
      
      if i == 0 {
        spinePath.move(to: pt)
      } else {
        spinePath.addLine(to: pt)
      }
    }
    
    // Create variable-width path with tapered ends
    path = Path.variableWidthPath(
      spine: spinePath,
      profile: .tapered(min: 1, max: style.width * 0.4),  // Adjust these values
      samples: samples
    )
  }
}
