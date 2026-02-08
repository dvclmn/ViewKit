//
//  DrawLinePath.swift
//  BaseDemos
//
//  Created by Dave Coleman on 24/1/2026.
//

import SwiftUI

//struct LinePathContext {
//  let start: CGPoint
//  let end: CGPoint
//  let style: ActionLine.LineStyle
//  
//
//  init(
//    from start: CGPoint,
//    to end: CGPoint,
//    with style: ActionLine.LineStyle
//  ) {
//    self.start = start
//    self.end = end
//    self.style = style
//  }
//}
//
//extension LinePathContext {
//
//  var triangle: Path {
//
//  }
//  var diamond: Path {
//    
//  }

  //  var wavy: Path {
  //    var path = Path()
  //    let delta = end - start
  //    let length = delta.length
  //    let angle = atan2(delta.y, delta.x)
  //
  //    // let cycles = style.cycles
  //    let cycles = moderatedCycles(for: style.cycles)
  //
  //    let amplitude = 8.0
  //    let steps = Int(max(2, length / 8))
  //    let stepLength = length / CGFloat(steps)
  //
  //    for i in 0..<steps {
  //      let t = Double(i) / Double(steps - 1)
  //      let x = CGFloat(t) * length
  //      let wave = sin(t * .pi * 2 * cycles)
  //      let y = CGFloat(wave) * amplitude
  //      let point = CGPoint(x: x, y: y)
  //      let rotated = CGPoint(
  //        x: point.x * cos(angle) - point.y * sin(angle),
  //        y: point.x * sin(angle) + point.y * cos(angle)
  //      )
  //      let actualPoint = start + rotated
  //      if i == 0 {
  //        path.move(to: actualPoint)
  //      } else {
  //        path.addLine(to: actualPoint)
  //      }
  //    }
  //    return path
  //  }

//  var wavy: Path {
//
//    
//  }
//}
