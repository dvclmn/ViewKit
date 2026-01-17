//
//  Path+Smooth.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 17/1/2026.
//

import SwiftUI

public enum PathType: String, Sendable, Hashable, Codable, CaseIterable, Identifiable {
  case line
  case smooth
  
  public var id: String { rawValue }
}

extension Array where Element == CGPoint {

  public func toPath(
    type: PathType = .line,
    shouldDropFirst: Bool = true
  ) -> Path {
    Path { path in
      processPath(type: type, shouldDropFirst: shouldDropFirst, path: &path)
    }
  }

  public func processPath(
    type: PathType = .line,
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
    }
  }

  private func processLinePath(
    shouldDropFirst: Bool = true,
    path: inout Path
  ) {
    guard let firstPoint = self.first else { return }
    let lines = shouldDropFirst ? Array(self.dropFirst()) : self
    path.move(to: firstPoint)
    path.addLines(lines)
  }

  /// Alternative: Smooth curved path using quadratic curves
  private func processSmoothPath(
    path: inout Path
  ) {
    guard self.count > 1 else { return }

    path.move(to: self[0])

    if self.count == 2 {
      path.addLine(to: self[1])
      return
    }

    /// Create smooth curves between points
    for i in 1..<self.count {
      let current = self[i]

      if i == self.count - 1 {
        /// Last point - just draw line
        path.addLine(to: current)

      } else {
        /// Use next point to create control point for smooth curve
        let next = self[i + 1]
        let controlPoint = CGPoint(
          x: (current.x + next.x) / 2,
          y: (current.y + next.y) / 2
        )
        path.addQuadCurve(to: controlPoint, control: current)
      }
    }
  }
}
