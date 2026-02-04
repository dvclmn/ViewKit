//
//  Model+PointShape.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 12/7/2025.
//

import CoreTools
import SwiftUI

public enum PointShape: String, Pickable, Sendable, Hashable, Identifiable, CaseIterable, Codable {
  case square
  case circle
  case cross
  case triangle
  case none
  
  public var id: String { rawValue }
  
  public var name: String { rawValue.capitalized }
  
  public var icon: String {
    switch self {
      case .square: "square.fill"
      case .circle: "circle.fill"
      case .cross: "circle.fill"
      case .triangle: "circle.fill"
      case .none: "circle.slash"
        //        case .diamond: "diamond.fill"
    }
  }
}

extension PointShape {
  /// Draw this PointShape into the provided Path using a center point and radius.
  ///
  /// This is the primary primitive for rendering point markers. Prefer calling this
  /// overload to avoid recomputing geometry (center/radius) from a rect.
  /// - Parameters:
  ///   - center: The center of the shape in the target coordinate space.
  ///   - radius: The overall size to render. Interpreted as the radius for circular shapes
  ///             and the half-extent for others (e.g. square half-side).
  ///   - path: The path to append the shape geometry to.
  public func updatePath(center: CGPoint, radius: CGFloat, path: inout Path) {
    switch self {
      case .square:
        let size = CGSize(width: radius * 2, height: radius * 2)
        let origin = CGPoint(x: center.x - radius, y: center.y - radius)
        path.addRect(CGRect(origin: origin, size: size))

      case .circle:
        let size = CGSize(width: radius * 2, height: radius * 2)
        let origin = CGPoint(x: center.x - radius, y: center.y - radius)
        path.addEllipse(in: CGRect(origin: origin, size: size))

      case .cross:
        path.move(to: CGPoint(x: center.x - radius, y: center.y))
        path.addLine(to: CGPoint(x: center.x + radius, y: center.y))
        path.move(to: CGPoint(x: center.x, y: center.y - radius))
        path.addLine(to: CGPoint(x: center.x, y: center.y + radius))

      case .triangle:
        // Equilateral-ish upright triangle inscribed in the circle of given radius
        let s: CGFloat = 0.707 // sin/cos(45deg) factor used in prior implementation
        path.move(to: CGPoint(x: center.x - radius * s, y: center.y + radius * s))
        path.addLine(to: CGPoint(x: center.x, y: center.y - radius))
        path.addLine(to: CGPoint(x: center.x + radius * s, y: center.y + radius * s))

      case .none:
        break
    }
  }

  /// Convenience overload that renders this shape inside a rect by
  /// deriving its center and radius. Prefer `updatePath(center:radius:path:)`
  /// when you already have those values to avoid duplicate calculations.
  /// - Parameters:
  ///   - rect: The bounding rect to draw within.
  ///   - path: The path to append the shape geometry to.
  public func updatePath(
    in rect: CGRect,
    path: inout Path
  ) {
    let center = CGPoint(x: rect.midX, y: rect.midY)
    let radius = min(rect.width, rect.height) / 2
    updatePath(center: center, radius: radius, path: &path)
  }
}
