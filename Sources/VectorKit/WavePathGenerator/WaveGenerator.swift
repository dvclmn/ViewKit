//
//  WaveformPathGenerator.swift
//  AnimationVisualiser
//
//  Created by Dave Coleman on 17/11/2024.
//

import SwiftUI

public struct WavePathGenerator {
  public var points: [CGPoint] = []
  var path: Path = .init()
  //  private var cachedControlPoints: [CGPoint]?

  public init(points: [CGPoint] = []) {
    self.points = points
  }
}

extension WavePathGenerator {
  
  /// Creates a path from a collection of points using the specified interpolation method
  /// - Parameters:
  ///   - points: Array of points to interpolate
  ///   - interpolation: The interpolation method to use
  /// - Returns: A new Path object, or nil if insufficient points
  public mutating func path(
    with interpolation: WaveInterpolation
  ) -> Path {
    guard !points.isEmpty else { return Path() }
    
    switch interpolation {
      case .linear: processLinear(shouldDropFirst: true)
        
      case .cubic(let tension): processCubic(tension: tension)
        //        usesAltCubicMethod ? createCubicCurvePath() : cubicPath()
        
      case .quadratic(let midpoint, let bias):
        processQuadPath(path: &path, cornerBias: bias)
        //        createQuadCurvePath()
        
      case .catmullRom(let variant, let tension, let samples):
        catmullRomAlt02(variant: variant, tension: tension, closed: false, samples: samples)
        //        catmullRomAlt(tension: tension, closed: false, samples: samples)
        //        catmullRom(variant: variant, closed: false)
        
    }
    return self.path
  }
  
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

