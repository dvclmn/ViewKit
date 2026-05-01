//
//  Model+PointShape.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 12/7/2025.
//

import BasePrimitives
import SwiftUI

public enum PointShape: String, Pickable, Sendable, Hashable, Identifiable, CaseIterable, Codable {
  
  public static let pickerLabel: QuickLabel = "Point Shape"
  
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
  ///   - point: The center of the shape in the target coordinate space.
  ///   - radius: The overall size to render. Interpreted as the radius for circular shapes
  ///             and the half-extent for others (e.g. square half-side).
  ///   - path: The path to append the shape geometry to.
  public func addShape(
    to path: inout Path,
    at point: CGPoint,
    radius: CGFloat,
  ) {
    switch self {
      case .square:
        let size = CGSize(width: radius * 2, height: radius * 2)
        let origin = CGPoint(x: point.x - radius, y: point.y - radius)
        path.addRect(CGRect(origin: origin, size: size))

      case .circle:
        let size = CGSize(width: radius * 2, height: radius * 2)
        let origin = CGPoint(x: point.x - radius, y: point.y - radius)
        path.addEllipse(in: CGRect(origin: origin, size: size))

      case .cross:
        path.move(to: CGPoint(x: point.x - radius, y: point.y))
        path.addLine(to: CGPoint(x: point.x + radius, y: point.y))
        path.move(to: CGPoint(x: point.x, y: point.y - radius))
        path.addLine(to: CGPoint(x: point.x, y: point.y + radius))

      case .triangle:
        /// Equilateral-ish upright triangle inscribed in the circle of given radius
        /// sin/cos(45deg) factor used in prior implementation
        let s: CGFloat = 0.707
        path.move(to: CGPoint(x: point.x - radius * s, y: point.y + radius * s))
        path.addLine(to: CGPoint(x: point.x, y: point.y - radius))
        path.addLine(to: CGPoint(x: point.x + radius * s, y: point.y + radius * s))

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
  @available(
    *, deprecated, renamed: "updatePath(center:radius:path:)",
    message:
      "Prefer `updatePath(center:radius:path:)` when you already have center and radius, to avoid redundant calculations"
  )
  public func updatePath(
    in rect: CGRect,
    path: inout Path,
  ) {
    let center = CGPoint(x: rect.midX, y: rect.midY)
    let radius = min(rect.width, rect.height) / 2
    addShape(to: &path, at: center, radius: radius)
  }
}
