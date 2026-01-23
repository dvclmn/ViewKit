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
  let baseAngles: [Double]  // Full set of angles for 2π
  let boundaryInner: [Double]  // Variation values
  let boundaryOuter: [Double]  // Variation values
  let density: Int

  /// Computed properties based on parameters
  func processedAngles(coverage: Double, rotation: Double) -> [Double] {
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
  ) -> ActionLineVariations {
    /// Generate base angles for full coverage
    let baseAngles = (0..<count).map { _ in
      Double.random(in: 0...(2 * .pi), using: &generator)
    }.sorted()

    /// Generate boundary variations
    let innerVariations = (0..<count).map { _ in
      Double.random(in: -1.0...1.0, using: &generator)
    }

    let outerVariations = (0..<count).map { _ in
      Double.random(in: -1.0...1.0, using: &generator)
    }

    return ActionLineVariations(
      baseAngles: baseAngles,
      boundaryInner: innerVariations,
      boundaryOuter: outerVariations,
      density: count
    )
  }
}
