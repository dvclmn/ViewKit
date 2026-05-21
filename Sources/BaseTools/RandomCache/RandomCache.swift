//
//  RandomCache.swift
//  Collection
//
//  Created by Dave Coleman on 11/12/2024.
//

import Foundation

/// A cache system for storing and retrieving randomly generated values.
///
/// The cache uses a combination of count and parameters to create
/// unique keys for storing values, ensuring consistent results for identical
/// inputs within the same session.
public struct RandomCache<T: RandomGeneratable> {
  private var values: [String: T] = [:]
  private var generator: RandomNumberGenerator

  /// Creates a new random cache with a specified seed.
  /// - Parameter seed: The seed value for the random number generator.
  public init(seed: UInt64) {
    self.generator = SeededGenerator(seed: seed)
  }

  /// Retrieves or generates cached values based on the provided parameters.
  /// - Parameters:
  ///   - count: The number of random values needed.
  ///   - parameters: Parameters influencing the generation.
  ///   - cacheKey: Optional custom key for caching. If nil, a key will be generated.
  /// - Returns: The cached or newly generated values.
  public mutating func values(
    count: Int,
    parameters: RandomisationParameters<T.Value>,
    cacheKey: String? = nil
  ) -> T {
    let key = cacheKey ?? "\(count)_\(parameters.hashValue)"

    if let cached = values[key] {
      return cached
    }

    let newValues = T.generate(
      count: count,
      using: &generator,
      parameters: parameters
    )
    values[key] = newValues
    return newValues
  }

  /// Clears all cached values.
  public mutating func reset() {
    values.removeAll()
  }
}
