//
//  WaveGenerator.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 31/1/2026.
//

import SwiftUI

import SwiftUI

@Observable
final class WaveGenerator {
  var points: [CGPoint] = []
  var path: Path = .init()
  var interpolation: WaveInterpolation = .linear
  var usesAltCubicMethod: Bool = false
//  private var cachedControlPoints: [CGPoint]?
}

extension WaveGenerator {
  public func resetAll() {
    resetPath()
    resetPoints()
  }
  public func resetPath() {
    path = .init()
  }
  public func resetPoints() {
    points.removeAll()
  }
  
  var hasTwoOrMorePoints: Bool { points.count >= 2 }
}

//public enum WaveError: Error {
//  case insufficientPointsToGeneratePath(String)
//}

// MARK: - Cached points
//extension WaveGenerator {
//  func setPoints(_ newPoints: [CGPoint]) {
//    points = newPoints
//    cachedControlPoints = nil // Invalidate on change
//  }
//  
//  var controlPoints: [CGPoint] {
//    if let cached = cachedControlPoints { return cached }
//    let computed = calculateCubicControlPoints(from: points)
////    let computed = computeControlPoints(from: points)
//    cachedControlPoints = computed
//    return computed
//  }
//}
