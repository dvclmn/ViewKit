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
    let lines = shouldDropFirst ? Array(points.dropFirst()) : points
    path.move(to: firstPoint)
    for point in lines {
      path.addShape(at: point, radius: radius, using: shape)
    }
    //    path.addLines(lines)
  }
}
