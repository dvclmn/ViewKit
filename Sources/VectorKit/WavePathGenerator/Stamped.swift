//
//  Stamped.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 4/2/2026.
//

import SwiftUI

extension WavePathGenerator {
  package mutating func processStamped(
    shape: PointShape,
    radius: CGFloat,
    shouldDropFirst: Bool = true,
  ) {
    guard let firstPoint = points.first else { return }
    let allPoints = shouldDropFirst ? Array(points.dropFirst()) : points
    path.move(to: firstPoint)
    for point in allPoints {
      path.addShape(at: point, using: shape, radius: radius)
//      path.addShape(at: point, radius: radius, using: shape)
    }
    //    path.addLines(lines)
  }
  
  func makeStampClosure(from style: FloatPointStyle?) -> Stamped {
    guard let style else { return { _, _, _ in } }
    return { index, point, path in
      /// draw subpath for style at point; e.g., a circle:
//      if case let .circle(radius) = style {
//        let rect = CGRect(x: point.x - radius, y: point.y - radius, width: radius * 2, height: radius * 2)
//        path.addEllipse(in: rect)
//      }
      style.shape.addShape(to: &path, at: point, radius: style.radius)
      
    }
  }
}
