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
  package mutating func processLinear(
    shouldDropFirst: Bool = true
  ) {
    guard let firstPoint = points.first else { return }
    let lines = shouldDropFirst ? Array(points.dropFirst()) : points
    path.move(to: firstPoint)
    path.addLines(lines)
  }
}
