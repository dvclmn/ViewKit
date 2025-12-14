//
//  ActionLinesHandler.swift
//  Components
//
//  Created by Dave Coleman on 24/11/2024.
//

import SwiftUI
import SharedHelpers

@Observable
@available(macOS 14.0, *)
final class ActionLineHandler {
  
  var randomGenerator: RandomValueGenerator<ActionLineVariations>
  private var cachedVariations: ActionLineVariations?
  var lines: ActionLineConfigurations
  
  init(seed: UInt64 = 0) {
    self.randomGenerator = RandomValueGenerator(seed: seed)
    self.lines = ActionLineConfigurations()
  }
  
  func getVariations() -> ActionLineVariations {
    /// Only regenerate if density changes or we don't have cached values
    if cachedVariations?.density != Int(lines.density) || cachedVariations == nil {
      cachedVariations = randomGenerator.generate(
        count: Int(lines.density),
        parameters: .init(ranges: [0...(2 * .pi), -1.0...1.0])
      )
    }
    
    return cachedVariations!
  }
  
  func reset(withSeed seed: UInt64) {
    randomGenerator = RandomValueGenerator(seed: seed)
    cachedVariations = nil
  }
  
  
  
  static func distanceToEdge(
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
        ///
        let distanceToVertical = switch dx {
          case 0:
            Double.infinity
          case let x where x > 0:
            (size.width - center.x) / dx
          default:
            -center.x / dx
        }
        
        /// Similar to horizontal but for vertical movement:
        ///
        /// Handles perfectly horizontal lines `(dy == 0)`
        /// For upward movement `(dy > 0)`, calculates distance to top edge
        /// For downward movement `(dy < 0)`, calculates distance to bottom edge
        ///
        let distanceToHorizontal = switch dy {
          case 0:
            Double.infinity
          case let y where y > 0:
            (size.height - center.y) / dy
          default:
            -center.y / dy
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
        ///
        return min(size.width, size.height) / 2
        
    }
  } // END distance to edge
  
  static func drawTrianglePath(
    from start: CGPoint,
    to end: CGPoint,
    in context: GraphicsContext,
    style: ActionLineStyle
  ) -> Path {
    let angle = atan2(end.y - start.y, end.x - start.x)
    let perpAngle: Double = angle + Double.pi / 2
    
    let x1 = end.x + cos(perpAngle) * style.width
    let y1 = end.y + sin(perpAngle) * style.width
    let x2 = end.x - cos(perpAngle) * style.width
    let y2 = end.y - sin(perpAngle) * style.width
    
    var path = Path()
    path.move(to: start)
    path.addLine(to: CGPoint(x: x1, y: y1))
    path.addLine(to: CGPoint(x: x2, y: y2))
    path.closeSubpath()
    
    return path
  }
  
  
}
