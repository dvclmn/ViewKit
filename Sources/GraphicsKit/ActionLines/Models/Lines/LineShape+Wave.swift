//
//  LineShape+Wave.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 9/2/2026.
//

import SwiftUI
import VectorKit

extension LineShape {
  package func wavePath(
    from start: CGPoint,
    to end: CGPoint,
    with style: ActionLine.LineStyle,
    strength: Double,
    samples: Int,
  ) -> (Path, cycles: Double) {
    let length = start.distance(to: end)

    let cycles = effectiveCycles(
      cycles: style.cycles,
      lineLength: length
    )

    let amplitude = style.width * strength
    let dx = end.x - start.x
    let dy = end.y - start.y

    /// Create the spine path (centerline of the wave)
    var spinePath = Path()
    let angle = atan2(dy, dx)
    let perp = CGPoint(x: -sin(angle), y: cos(angle))

    for i in 0...samples {
      let t = Double(i) / Double(samples)
      let px = start.x + dx * t
      let py = start.y + dy * t

      let phaseTurns = t * cycles
      let wave = WaveSampler<Double>.sample(.sine, phase: phaseTurns, domain: .turns)

      let wx = px + perp.x * wave * amplitude
      let wy = py + perp.y * wave * amplitude
      let pt = CGPoint(x: wx, y: wy)

      if i == 0 {
        spinePath.move(to: pt)
      } else {
        spinePath.addLine(to: pt)
      }
    }

    /// Create variable-width path with tapered ends
    let path = Path.variableWidthPath(
      spine: spinePath,
      profile: .tapered(min: style.minWidth, max: style.maxWidth),
      samples: samples
    )
    return (path, cycles)
  }
}
