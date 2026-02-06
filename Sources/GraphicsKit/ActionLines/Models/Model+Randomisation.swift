//
//  Model+Randomisation.swift
//  Components
//
//  Created by Dave Coleman on 24/11/2024.
//

import CoreTools
import SwiftUI

public struct ActionLineVariations: RandomGeneratable {

  public typealias Value = Double

  /// Base random values, `baseAngles` and `boundary`
  /// Only regenerated when density or seed changes
  public let baseAngles: [Double]
  public let boundary: [Double]
  public let density: Int

  public init(
    baseAngles: [Double] = [],
    boundary: [Double] = [],
    density: Int = 10
  ) {
    self.baseAngles = baseAngles
    self.boundary = boundary
    self.density = density
  }
}

extension ActionLineVariations {

  /// Computed properties based on parameters
  public func processedAngles(
    coverage: Double,
    rotation: Double
  ) -> [Double] {
    let targetCount = Int(Double(density) * coverage)
    return
      baseAngles
      .prefix(targetCount)
      .map { $0 + rotation.omega }
  }

  public static func generate(
    count: Int,
    using generator: inout RandomNumberGenerator,
    parameters spec: RandomisationParameters<Value>
  ) -> Self {
    
    // Angles default to [0, 2π], unless bounds were explicitly provided.
    let angleRanges = spec.bounds.ranges.isEmpty ? [0.0...(2.0 * .pi)] : spec.bounds.ranges
    
    // Boundary defaults to [-1, 1] unless bounds were provided.
    let boundaryRanges = spec.bounds.ranges.isEmpty ? [-1.0...1.0] : spec.bounds.ranges
    
    func randomFrom(_ ranges: [ClosedRange<Double>], using g: inout RandomNumberGenerator) -> Double {
      // Pick a range uniformly, then sample uniformly within it.
      let idx = Int.random(in: 0..<ranges.count, using: &g)
      let r = ranges[idx]
      return Double.random(in: r, using: &g)
    }
    
    var g = generator // copy if you need to separate streams; otherwise use &generator
    
    let baseAngles = (0..<count)
      .map { _ in randomFrom(angleRanges, using: &g) }
      .sorted()
    
    let boundary = (0..<count)
      .map { _ in randomFrom(boundaryRanges, using: &g) }
    
    return ActionLineVariations(
      baseAngles: baseAngles,
      boundary: boundary,
      density: count
    )
  }

  
//  public static func generate(
//    count: Int,
//    using generator: inout RandomNumberGenerator,
//    parameters: RandomisationParameters<Value>
//  ) -> Self {
//
//    let baseAngles = (0..<count).map { _ in
//      Double.random(in: 0...(2 * .pi), using: &generator)
//    }.sorted()
//
//    let boundary = (0..<count).map { _ in
//      Double.random(in: -1.0...1.0, using: &generator)
//    }
//
//    return ActionLineVariations(
//      baseAngles: baseAngles,
//      boundary: boundary,
//      density: count
//    )
//  }
}
