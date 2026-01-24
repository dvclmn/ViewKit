//
//  ActionLinesHandler.swift
//  Components
//
//  Created by Dave Coleman on 24/11/2024.
//

import CoreTools
import GraphicsKit
import SwiftUI

public struct ActionLineHandler {

  public static func distanceToEdge(
    from center: CGPoint,
    angle: Double,
    in size: CGSize,
    with boundaryShape: BoundaryShape
  ) -> Double {

    /// This converts the angle into `x` and `y` components using trigonometry
    /// These values represent the direction vector, always having a length of `1` (unit vector)
    /// `dx` is the horizontal component (-1 to 1)
    /// `dy` is the vertical component (-1 to 1)
    ///
    let dx = cos(angle)
    let dy = sin(angle)

    switch boundaryShape {
      case .square:

        /// Handles the case when the line is perfectly vertical `(dx == 0)`
        /// For rightward movement `(dx > 0)`, calculates distance to right edge
        /// For leftward movement `(dx < 0)`, calculates distance to left edge
        /// Uses `.infinity` to handle vertical lines, ensuring they don't affect the final minimum
        let distanceToVertical =
          switch dx {
            case 0: Double.infinity
            case let x where x > 0: (size.width - center.x) / dx
            default: -center.x / dx
          }

        /// Similar to horizontal but for vertical movement:
        ///
        /// Handles perfectly horizontal lines `(dy == 0)`
        /// For upward movement `(dy > 0)`, calculates distance to top edge
        /// For downward movement `(dy < 0)`, calculates distance to bottom edge
        let distanceToHorizontal =
          switch dy {
            case 0: Double.infinity
            case let y where y > 0: (size.height - center.y) / dy
            default: -center.y / dy
          }

        /// Takes the shorter of the two distances
        /// Uses `abs()` to ensure positive distance
        /// This gives us the shortest distance to any edge along the angle
        return min(abs(distanceToVertical), abs(distanceToHorizontal))

      case .circle:

        /// Circle fits inside the rectangle
        ///
        /// Note: Here is an alternative method, where circle encompasses the rectangle:
        /// `let radius = sqrt(pow(size.width / 2, 2) + pow(size.height / 2, 2))`
        return min(size.width, size.height) / 2

      case .matchViewport:
        fatalError("Not yet implemented")
    }
  }  // END distance to edge

  public static func drawPath(
    from start: CGPoint,
    to end: CGPoint,
    in context: GraphicsContext,
    style: ActionLine.Style
  ) -> Path {
    var path = Path()
    switch style.shape {
      case .triangle:
        let angle = atan2(end.y - start.y, end.x - start.x)
        let perpAngle: Double = angle + Double.pi / 2

        let x1 = end.x + cos(perpAngle) * style.width
        let y1 = end.y + sin(perpAngle) * style.width
        let x2 = end.x - cos(perpAngle) * style.width
        let y2 = end.y - sin(perpAngle) * style.width

        path.move(to: start)
        path.addLine(to: CGPoint(x: x1, y: y1))
        path.addLine(to: CGPoint(x: x2, y: y2))
        path.closeSubpath()

      case .diamond:
        let angle = atan2(end.y - start.y, end.x - start.x)
        let perpAngle: Double = angle + Double.pi / 2
        let mid = CGPoint(x: (start.x + end.x) / 2, y: (start.y + end.y) / 2)
        let perpOffsetX = cos(perpAngle) * style.width
        let perpOffsetY = sin(perpAngle) * style.width
        let perp1 = CGPoint(x: mid.x + perpOffsetX, y: mid.y + perpOffsetY)
        let perp2 = CGPoint(x: mid.x - perpOffsetX, y: mid.y - perpOffsetY)
        path.move(to: start)
        path.addLine(to: perp1)
        path.addLine(to: end)
        path.addLine(to: perp2)
        path.closeSubpath()

      case .wave:
        
    }
    return path
  }
  
  private static func drawWavy(
    from start: CGPoint,
    to end: CGPoint,
    style: ActionLine.Style
  ) -> Path {
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
    path = context.variableWidthPath(
      spine: spinePath,
      profile: .tapered(min: 1, max: style.width * 0.4),  // Adjust these values
      samples: samples
    )
  }

}
