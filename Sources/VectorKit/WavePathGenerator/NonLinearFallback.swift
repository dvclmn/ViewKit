//
//  NonLinearFallback.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 4/2/2026.
//

import SwiftUI

/// Alternative; consider leaving WavePathGenerator out of this, and
/// just create a tiny polyline fallback instead
/// ```
/// { path, pts, _ in
///   guard let first = pts.first else { return }
///   path.move(to: first)
///   for p in pts.dropFirst() { path.addLine(to: p) }
/// }
/// ```
package typealias PathFallBack = (inout Path, [CGPoint], inout WavePathGenerator) -> Void
package struct NonLinearPathFallback {
  let minRequiredPoints: Int
  let fallback: PathFallBack?
  
  init(
    minRequiredPoints: Int,
    fallback: PathFallBack? = nil
  ) {
    self.minRequiredPoints = minRequiredPoints
    self.fallback = fallback
  }
}

extension NonLinearPathFallback {
  static var defaultLinear: NonLinearPathFallback {
    NonLinearPathFallback(minRequiredPoints: 4) {
      path,
      pts,
      generator in
      /// Temporarily swap generator points if needed
      let original = generator.points
      generator.points = pts
      defer { generator.points = original }
      
      /// Use linear processor as the fallback
      generator.processLinear(path: &path)
    }
  }
}
