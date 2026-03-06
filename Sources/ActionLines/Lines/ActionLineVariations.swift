//
//  Model+Randomisation.swift
//  Components
//
//  Created by Dave Coleman on 24/11/2024.
//

//import CoreTools
import BasePrimitives
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

    /// Determine angle and boundary domains.
    let bounds = spec.domain.ranges

    /// Generate stable base sequences given seed, count, and spec.
    let boundary = (0..<count).map { _ in
      sample(from: bounds, using: &generator)
    }

    let baseAngles = boundary.sorted()

    return ActionLineVariations(
      baseAngles: baseAngles,
      boundary: boundary,
      density: count
    )
  }

  /// Helper to sample uniformly from a composite domain.
  private static func sample(
    from ranges: [ClosedRange<Double>],
    using g: inout RandomNumberGenerator
  ) -> Double {
    let idx = Int.random(in: 0..<ranges.count, using: &g)
    let r = ranges[idx]
    return Double.random(in: r, using: &g)
  }
}
