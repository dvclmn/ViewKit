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

  /// Base random values (only regenerated when density or seed changes)
  //  public let baseAngles: [Double]  // Full set of angles for 2π
  //  public let boundaryInner: [Double]  // Variation values
  //  public let boundaryOuter: [Double]  // Variation values
  //  public let density: Int

  public let baseAngles: [Double]
  public let boundary: [Double]
  public let density: Int

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
    parameters: RandomisationParameters
  ) -> Self {

    let baseAngles = (0..<count).map { _ in
      Double.random(in: 0...(2 * .pi), using: &generator)
    }.sorted()

    let boundary = (0..<count).map { _ in
      Double.random(in: -1.0...1.0, using: &generator)
    }

    return ActionLineVariations(
      baseAngles: baseAngles,
      boundary: boundary,
      density: count
    )
  }

  //  public static func generate(
  //    count: Int,
  //    using generator: inout RandomNumberGenerator,
  //    parameters: RandomisationParameters
  //  ) -> Self {
  //
  //    /// Generate base angles for full coverage
  //    let baseAngles = (0..<count).map { _ in
  //      Double.random(in: 0...(2 * .pi), using: &generator)
  //    }.sorted()
  //
  //    /// Generate boundary variations
  //    let innerVariations = (0..<count).map { _ in
  //      Double.random(in: -1.0...1.0, using: &generator)
  //    }
  //
  //    let outerVariations = (0..<count).map { _ in
  //      Double.random(in: -1.0...1.0, using: &generator)
  //    }
  //
  //    return ActionLineVariations(
  //      baseAngles: baseAngles,
  //      boundaryInner: innerVariations,
  //      boundaryOuter: outerVariations,
  //      density: count
  //    )
  //  }
}
