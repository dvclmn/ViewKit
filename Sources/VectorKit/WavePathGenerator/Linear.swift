//
//  Path+Ext.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 29/1/2026.
//

import SwiftUI

extension WavePathGenerator {

  // MARK: - Linear Interpolation

  /// Creates a path by connecting points with straight lines
  /// This is the fastest method, ideal when smoothness isn't required
  //  package mutating func processLinear(
  //    shouldDropFirst: Bool = true
  //  ) {
  //    guard let firstPoint = points.first else { return }
  //    let allPoints = shouldDropFirst ? Array(points.dropFirst()) : points
  //    path.move(to: firstPoint)
  //    path.addLines(allPoints)
  //  }

  package mutating func processLinear(
    shouldDropFirst: Bool = true,
    path: inout Path,
    stamped: Stamped = { _, _, _ in }
  ) {
    guard let firstPoint = points.first else { return }
    let allPoints = shouldDropFirst ? Array(points.dropFirst()) : points
    path.move(to: firstPoint)
    for point in allPoints {
      path.addLine(to: point)

    }
    //    path.addLines(lines)
  }
}
