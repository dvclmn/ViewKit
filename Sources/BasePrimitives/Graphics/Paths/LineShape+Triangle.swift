//
//  LineShape+Triangle.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 9/2/2026.
//

import SwiftUI

extension LineShape {
  package func trianglePath(
    from start: CGPoint,
    to end: CGPoint,
    minWidth: CGFloat,
    maxWidth: CGFloat
  ) -> (Path, cycles: Double) {
    let path = Path { path in
      let angle = atan2(end.y - start.y, end.x - start.x)
      let perpAngle: Double = angle + Double.pi / 2
      
      let x1 = end.x + cos(perpAngle) * minWidth
      let y1 = end.y + sin(perpAngle) * maxWidth
      let x2 = end.x - cos(perpAngle) * minWidth
      let y2 = end.y - sin(perpAngle) * maxWidth
      
      path.move(to: start)
      path.addLine(to: CGPoint(x: x1, y: y1))
      path.addLine(to: CGPoint(x: x2, y: y2))
      path.closeSubpath()
    }
    return (path, 0.0)
  }
}
