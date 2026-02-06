//
//  RandomGeneratable.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 23/1/2026.
//

import Foundation

/// A protocol that defines types capable of generating random values.
///
/// Types conforming to `RandomGeneratable` must implement a
/// method to generate random values based on specified parameters
/// and a random number generator.
///
/// Note: `GraphicsKit/ActionLineVariations` is a good
/// example of this system in use.
nonisolated public protocol RandomGeneratable: Equatable, Hashable {
  
  /// Conformance to `BinaryFloatingPoint` neccessary to ensure
  /// compatibility with floating-point random operations.
  associatedtype Value: BinaryFloatingPoint
  
  /// Defines *how* a conforming type produces random data
  /// The core, stateless randomization engine. It’s deterministic for the same
  /// seed and parameters, and doesn’t care about caching.
  /// - Parameters:
  ///   - count: The number of random values to generate.
  ///   - generator: The random number generator to use.
  ///   - parameters: Parameters that influence the random generation.
  /// - Returns: A new instance containing the generated random values.
  static func generate(
    count: Int,
    using generator: inout any RandomNumberGenerator,
    parameters: RandomisationParameters<Value>
  ) -> Self
}

public extension RandomGeneratable {
  static func generate(
    count: Int,
    using generator: inout any RandomNumberGenerator,
    spec: RandomisationSpec<Value>
  ) -> Self {
    generate(count: count, using: &generator, parameters: spec)
  }
}

/// Constraint `where Value.RawSignificand: FixedWidthInteger`
/// seems to allow 'seeing' that `random(in:using:)` method
extension RandomGeneratable where Value.RawSignificand: FixedWidthInteger {
  public static func generate(
    count: Int,
    using generator: inout RandomNumberGenerator,
    parameters: RandomisationParameters<Value>
  ) -> Value {
    
    /// Generate a single random value using the first available range
    guard let range = parameters.domain.ranges.first else {
      return 0
    }
    return Value.random(in: range, using: &generator)
  }
}

