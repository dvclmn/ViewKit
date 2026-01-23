//
//  RandomGeneratable.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 23/1/2026.
//

import Foundation

/// A protocol that defines types capable of generating random values.
///
/// Types conforming to `RandomGeneratable` must implement a method to generate random values
/// based on specified parameters and a random number generator.
///
/// - Note: The associated `Value` type must conform to `BinaryFloatingPoint` to ensure
///         compatibility with floating-point random operations.
///
nonisolated public protocol RandomGeneratable {
  associatedtype Value: BinaryFloatingPoint
  
  /// Generates a new instance with random values.
  /// - Parameters:
  ///   - count: The number of random values to generate.
  ///   - generator: The random number generator to use.
  ///   - parameters: Parameters that influence the random generation.
  /// - Returns: A new instance containing the generated random values.
  static func generate(
    count: Int,
    using generator: inout RandomNumberGenerator,
    parameters: RandomisationParameters
  ) -> Self
}
