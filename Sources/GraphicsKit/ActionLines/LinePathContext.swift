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
  let style: ActionLine.LineStyle

  init(
    from start: CGPoint,
    to end: CGPoint,
    with style: ActionLine.LineStyle
  ) {
    self.start = start
    self.end = end
    self.style = style
  }
}

extension LinePathContext {
  var triangle: Path {
    Path { path in
      let angle = atan2(end.y - start.y, end.x - start.x)
      let perpAngle: Double = angle + Double.pi / 2

      let x1 = end.x + cos(perpAngle) * style.minWidth
      let y1 = end.y + sin(perpAngle) * style.maxWidth
      let x2 = end.x - cos(perpAngle) * style.minWidth
      let y2 = end.y - sin(perpAngle) * style.maxWidth

      path.move(to: start)
      path.addLine(to: CGPoint(x: x1, y: y1))
      path.addLine(to: CGPoint(x: x2, y: y2))
      path.closeSubpath()
    }

  }
  var diamond: Path {
    return Path { path in
      let angle = atan2(end.y - start.y, end.x - start.x)
      let perpAngle: Double = angle + Double.pi / 2
      let mid = CGPoint(x: (start.x + end.x) / 2, y: (start.y + end.y) / 2)

      let perpOffsetX = cos(perpAngle) * style.minWidth
      let perpOffsetY = sin(perpAngle) * style.maxWidth

      let perp1 = CGPoint(x: mid.x + perpOffsetX, y: mid.y + perpOffsetY)
      let perp2 = CGPoint(x: mid.x - perpOffsetX, y: mid.y - perpOffsetY)
      path.move(to: start)
      path.addLine(to: perp1)
      path.addLine(to: end)
      path.addLine(to: perp2)
      path.closeSubpath()
    }
  }

  var wavy: Path {

    let cycles = style.cycles
    let amplitude = style.width
    let samples = style.sampleCount

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

    /// Create variable-width path with tapered ends
    return Path().variableWidthPath(
      spine: spinePath,
      profile: .tapered(
        min: style.minWidth,
        max: style.maxWidth
      ),
      samples: samples
    )
  }
}
