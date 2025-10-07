//
//  Ext+Path.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 7/10/2025.
//


import SwiftUI

extension Path {
  
  public init(
    fromPoints points: [CGPoint],
    type: PathType = .line,
    shouldDropFirst: Bool = true
  ) {
    self = points.toPath(type: type, shouldDropFirst: shouldDropFirst)
  }
  
  public static func catmullRomPath(
    points: [CGPoint],
    tension: CGFloat = 0.5,
    closed: Bool = false,
    samples: Int = 16
  ) -> Path {
    var path = Path()
    guard points.count > 1 else { return path }
    
    let n = points.count
    
    // Start at first point
    path.move(to: points[0])
    
    for i in 0..<n-1 {
      var p0 = points[(i - 1 + n) % n]
      let p1 = points[i]
      let p2 = points[(i + 1) % n]
      var p3 = points[(i + 2) % n]
      
      // For open curves, don't wrap around
      if !closed {
        if i == 0 { p0 = p1 }
        if i == n - 2 { p3 = p2 }
      }
      
      // Sample the curve between p1 and p2
      for j in 1...samples {
        let t = CGFloat(j) / CGFloat(samples)
        let tt = t * t
        let ttt = tt * t
        
        let q0 = -tension * ttt + 2 * tension * tt - tension * t
        let q1 = (2 - tension) * ttt + (tension - 3) * tt + 1
        let q2 = (tension - 2) * ttt + (3 - 2 * tension) * tt + tension * t
        let q3 = tension * ttt - tension * tt
        
        let x = q0 * p0.x + q1 * p1.x + q2 * p2.x + q3 * p3.x
        let y = q0 * p0.y + q1 * p1.y + q2 * p2.y + q3 * p3.y
        
        path.addLine(to: CGPoint(x: x, y: y))
      }
    }
    
    return path
  }
}
