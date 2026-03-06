//
//  ActionLinesHandler.swift
//  Components
//
//  Created by Dave Coleman on 24/11/2024.
//

//import BasePrimitives
import SwiftUI

extension ActionLine {

  /// Finds the right distance to make the lines, to form a circle/square boundary
  public static func distanceToEdge(
    from center: CGPoint,
    angle: Double,
    in size: CGSize,
    with boundaryShape: BoundaryShape
  ) -> Double {

    let effectiveSize = size.adjustBoth { max(0.1, $0) }

    /// This converts the angle into `x` and `y` components using trigonometry
    /// These values represent the direction vector, always having a length of `1` (unit vector)
    /// `dx` is the horizontal component (-1 to 1)
    /// `dy` is the vertical component (-1 to 1)
    let dx = cos(angle)
    let dy = sin(angle)

    return switch boundaryShape {
      case .square:
        handleSquareBoundary(dx, dy, size: effectiveSize, center: center)

      case .circle:
        handleCircleBoundary(size: effectiveSize)

      case .matchViewport:
        fatalError("Not yet implemented")
    }
  }  // END distance to edge

  public static func drawPath(
    from start: CGPoint,
    to end: CGPoint,
    style: ActionLine.LineStyle
  ) -> (Path, cycles: Double) {
    style.shape.path(from: start, to: end, with: style)
  }

  private static func handleSquareBoundary(
    _ dx: Double,
    _ dy: Double,
    size: CGSize,
    center: CGPoint
  ) -> Double {

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
  }

  private static func handleCircleBoundary(size: CGSize) -> Double {

    /// Circle fits inside the rectangle
    ///
    /// Note: Here is an alternative method, where circle encompasses the rectangle:
    /// `let radius = sqrt(pow(size.width / 2, 2) + pow(size.height / 2, 2))`
    return min(size.width, size.height) / 2
  }
}
