//
//  Ext+CGPoint.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 7/10/2025.
//

import SwiftUI


public enum PathType {
  case line
  case smooth
}


extension Array where Element == CGPoint {
  
  public func toPath(
    type: PathType = .line,
    shouldDropFirst: Bool = true
  ) -> Path {
    switch type {
      case .line:
        return Path { path in
          guard let firstPoint = self.first else { return }
          let lines = shouldDropFirst ? Array(self.dropFirst()) : self
          path.move(to: firstPoint)
          path.addLines(lines)
        }
        
      case .smooth:
        return toSmoothPath()
    }
  }
  
  /// Alternative: Smooth curved path using quadratic curves
  func toSmoothPath() -> Path {
    return Path { path in
      guard self.count > 1 else { return }
      
      path.move(to: self[0])
      
      if self.count == 2 {
        path.addLine(to: self[1])
        return
      }
      
      // Create smooth curves between points
      for i in 1..<self.count {
        let current = self[i]
        
        if i == self.count - 1 {
          // Last point - just draw line
          path.addLine(to: current)
        } else {
          // Use next point to create control point for smooth curve
          let next = self[i + 1]
          let controlPoint = CGPoint(
            x: (current.x + next.x) / 2,
            y: (current.y + next.y) / 2
          )
          path.addQuadCurve(to: controlPoint, control: current)
        }
      }
    }
  }
}
