//
//  Conformances.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 5/3/2025.
//

import Foundation

extension RandomGeneratable where Value.RawSignificand: FixedWidthInteger {
  public static func generate(
    count: Int,
    using generator: inout RandomNumberGenerator,
    parameters: RandomisationParameters<Value>
  ) -> Value {
    /// Generate a single random value using the provided range
    guard let range = parameters.ranges.first else {
      return 0
    }
    return Value.random(in: range, using: &generator)
  }
}
