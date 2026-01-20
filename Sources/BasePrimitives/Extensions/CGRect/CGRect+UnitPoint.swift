//
//  CGRect+Point.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 14/1/2026.
//

import SwiftUI

/// ```
/// ● = origin
///
///                   midX
///                    |
/// minX,minY ● ───────|────────┐ maxX,minY
///           │                 │
///           │                 │
///           │                 │
///    midY --—      CGRect     --- midY
///           │                 │
///           │                 │
///           │                 │
/// minX,maxY └────────|────────┘ maxX,maxY
///                    |
///                   midX
///
/// ```
///
/// `UnitPoint` maps nicely to `CGRect`'s coordinate methods:
///
/// ```
/// minX, minY → topLeading
/// maxX, minY → topTrailing
/// minX, maxY → bottomLeading
/// maxX, maxY → bottomTrailing
/// midX, minY → top
/// minX, midY → leading
/// maxX, midY → trailing
/// midX, maxY → bottom
/// midX, midY → center
///
/// ```

extension CGRect {

  /// Get a UnitPoint representing where a CGPoint falls within this rect
  /// - Parameter point: The CGPoint to convert
  /// - Returns: The normalized UnitPoint (may be outside 0.0-1.0 if point is outside rect)
  ///
  /// Note: Assumes origin top-left, y increasing downward, as it is in SwiftUI
  public func unitPoint(for point: CGPoint) -> UnitPoint {
    return UnitPoint(
      x: width > 0 ? (point.x - minX) / width : 0,
      y: height > 0 ? (point.y - minY) / height : 0
    )
  }

  /// Get a CGPoint at the specified UnitPoint within this rect
  /// The inverse of ``unitPoint(for:)``
  ///
  /// Note: Assumes origin top-left, y increasing downward, as it is in SwiftUI
  public func point(at unitPoint: UnitPoint) -> CGPoint {
    return CGPoint(
      x: minX + (unitPoint.x * width),
      y: minY + (unitPoint.y * height)
    )
  }

  /// `CGRect` represents a rectangle in a 2D coordinate system.
  /// The `origin` property represents the starting point (or the top-left corner).
  ///
  /// `origin`A CGPoint that specifies the (x, y) coordinates of the rectangle's top-left corner.
  /// `minX` Equals `origin.x`, representing the left edge of the rectangle.
  /// `minY` Equals `origin.y`, representing the top edge of the rectangle.
  /// `maxX` Calculated as `origin.x + width`, representing the right edge of the rectangle.
  /// `maxY` Calculated as `origin.y + height`, representing the bottom edge of the rectangle.
  /// `width` The width of the rectangle, defined as `maxX - minX`.
  /// `height`The height of the rectangle, defined as `maxY - minY`.
  ///
  /// ### Summary
  /// -  The `origin` defines the position of the rectangle in the coordinate system.
  /// -  `minX` and `minY` are directly derived from the `origin`.
  /// -  The dimensions (`width` and `height`) are used in conjunction with the
  /// `origin` to determine the rectangle's boundaries (`maxX` and `maxY`).

  // MARK: - Common UnitPoint Positions as CGPoints

  /// Top-left corner (minX, minY)
  public var topLeading: CGPoint { point(at: .topLeading) }

  /// Top-center (midX, minY)
  public var top: CGPoint { point(at: .top) }

  /// Top-right corner (maxX, minY)
  public var topTrailing: CGPoint { point(at: .topTrailing) }

  /// Center-left (minX, midY)
  public var leading: CGPoint { point(at: .leading) }

  /// Dead center (midX, midY)
  public var center: CGPoint { point(at: .center) }

  /// Center-right (maxX, midY)
  public var trailing: CGPoint { point(at: .trailing) }

  /// Bottom-left corner (minX, maxY)
  public var bottomLeading: CGPoint { point(at: .bottomLeading) }

  /// Bottom-center (midX, maxY)
  public var bottom: CGPoint { point(at: .bottom) }

  /// Bottom-right corner (maxX, maxY)
  public var bottomTrailing: CGPoint { point(at: .bottomTrailing) }

  // Edges
  public var leadingEdge: CGFloat { minX }
  public var trailingEdge: CGFloat { maxX }
  public var topEdge: CGFloat { minY }
  public var bottomEdge: CGFloat { maxY }

  // Dimensions
  #warning("TODO: Needs to be passed through the AxisMapping pipeline, to be safer")
  public var horizontal: ClosedRange<CGFloat> { minX...maxX }
  
#warning("TODO: Needs to be passed through the AxisMapping pipeline, to be safer")
  public var vertical: ClosedRange<CGFloat> { minY...maxY }

}
