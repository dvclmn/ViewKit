//
//  LineShape+Diamond.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 9/2/2026.
//

import SwiftUI

extension LineShape {
  package func diamondPath(
    from start: CGPoint,
    to end: CGPoint,
    minWidth: CGFloat,
    maxWidth: CGFloat
  ) -> (Path, cycles: Double) {
    
    let path = Path { path in
      let angle = atan2(end.y - start.y, end.x - start.x)
      let perpAngle: Double = angle + Double.pi / 2
      let mid = start.midpoint(to: end)
      let perpOffsetX = cos(perpAngle) * minWidth
      let perpOffsetY = sin(perpAngle) * maxWidth
      
      let perp1 = CGPoint(x: mid.x + perpOffsetX, y: mid.y + perpOffsetY)
      let perp2 = CGPoint(x: mid.x - perpOffsetX, y: mid.y - perpOffsetY)
      path.move(to: start)
      path.addLine(to: perp1)
      path.addLine(to: end)
      path.addLine(to: perp2)
      path.closeSubpath()
    }
    return (path, 0.0)

  }
  
}
