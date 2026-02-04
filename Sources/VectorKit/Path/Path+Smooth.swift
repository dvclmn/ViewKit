//
//  Path+Smooth.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 17/1/2026.
//

import CoreTools
import SwiftUI

extension Array where Element == CGPoint {

  public func createPath(
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
  
  
}
