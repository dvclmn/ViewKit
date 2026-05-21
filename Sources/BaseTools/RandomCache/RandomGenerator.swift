//
//  RandomGenerator.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 23/1/2026.
//

import Foundation

/// An interface for generating and caching random values.
///
/// This generator provides a convenient way to work with cached random values
/// while abstracting away the details of cache management.
public struct RandomValueGenerator<T: RandomGeneratable> {
  private var cache: RandomCache<T>
  
  /// Creates a new generator with a specified seed.
  /// - Parameter seed: The seed value for the random number generator.
  public init(seed: UInt64) {
    self.cache = RandomCache(seed: seed)
  }
  
  /// Generates or retrieves cached random values.
  /// Delegates actual random generation to `RandomGeneratable`
  /// - Parameters:
  ///   - count: The number of random values needed.
  ///   - parameters: Parameters influencing the generation.
  ///   - cacheKey: Optional custom key for caching.
  /// - Returns: The generated or cached values.
  public mutating func cachedValue(
    count: Int,
    parameters: RandomisationParameters<T.Value>,
    cacheKey: String? = nil
  ) -> T {
    cache.values(
      count: count,
      parameters: parameters,
      cacheKey: cacheKey
    )
  }
  
  /// Resets the internal cache.
  public mutating func reset() {
    cache.reset()
  }
}

/// A random number generator that produces consistent results based on a seed value.
public struct SeededGenerator: RandomNumberGenerator {
  /// Creates a new seeded generator.
  /// - Parameter seed: The seed value for the generator.
  public init(seed: UInt64) {
    srand48(Int(seed))
  }
  
  /// Generates the next random value.
  /// - Returns: A random UInt64 value.
  public func next() -> UInt64 {
    UInt64(drand48() * Double(UInt64.max))
  }
}
