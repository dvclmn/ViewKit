//
//  Path+Smooth.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 17/1/2026.
//

import CoreTools
import SwiftUI

extension Array where Element == CGPoint {

  public func toPath(
    type: PathStyle = .line,
    shouldDropFirst: Bool = true
  ) -> Path {
    Path { path in
      processPath(type: type, shouldDropFirst: shouldDropFirst, path: &path)
    }
  }

  public func processPath(
    type: PathStyle = .line,
    shouldDropFirst: Bool = true,
    path: inout Path
  ) {
    switch type {
      case .line:
        processLinePath(
          shouldDropFirst: shouldDropFirst,
          path: &path
        )

      case .smooth:
        processSmoothPath(path: &path)

      case .stamped(let shape, let radius):
        processStampedPath(
          shouldDropFirst: shouldDropFirst,
          shape: shape,
          radius: radius,
          path: &path
        )
    }
  }

  private func processStampedPath(
    shouldDropFirst: Bool = true,
    shape: PointShape,
    radius: CGFloat,
    path: inout Path
  ) {
    guard let firstPoint = self.first else { return }
    let lines = shouldDropFirst ? Array(self.dropFirst()) : self
    path.move(to: firstPoint)
    for point in lines {
      path.addShape(at: point, radius: radius, using: shape)
    }
    //    path.addLines(lines)
  }

  /// Smooth curved path using quadratic curves
  private func processSmoothPath(
    midpointFactor: Double = 0.5,
    path: inout Path
  ) {
    guard count > 1 else { return }

    path.move(to: self[0])

    if count == 2 {
      path.addLine(to: self[1])
      return
    }

    for i in 1..<(count - 1) {
      let current = self[i]
      let next = self[i + 1]
      let mid = CGPoint(
        x: (current.x + next.x) * midpointFactor,
        y: (current.y + next.y) * midpointFactor)
      path.addQuadCurve(to: mid, control: current)
    }

    /// Finish with a quad curve to the last point
    path.addQuadCurve(to: self[count - 1], control: self[count - 2])
  }
  
}
