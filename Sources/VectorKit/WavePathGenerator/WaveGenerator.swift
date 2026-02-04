//
//  WaveformPathGenerator.swift
//  AnimationVisualiser
//
//  Created by Dave Coleman on 17/11/2024.
//

import SwiftUI

public struct WavePathGenerator {
  public var points: [CGPoint] = []
  //  private var cachedControlPoints: [CGPoint]?

  public
    init()
  {}
}

extension WavePathGenerator {
//  public mutating func resetAll() {
//    resetPath()
//    resetPoints()
//  }
//  public mutating func resetPath() {
//    path = .init()
//  }
  public mutating func resetPoints() {
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

