//
//  RandomisationParameters.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 23/1/2026.
//

import Foundation

/// Example usage:
/// ```
/// // Define a spec with a single range and a skew influence
/// var spec = RandomizationSpec<Double>(range: 0.0...1.0)
/// spec.setInfluence(0.25, for: .skew)
/// spec.setInfluence(true, for: .smoothTransitions)
///
/// // Read influences
/// let skew: Double? = spec.influence(for: .skew)
/// let smoothing: Bool? = spec.influence(for: .smoothTransitions)
///
/// // Multiple ranges
/// let spec2 = RandomizationSpec<Double>(ranges: [0.0...0.2, 0.8...1.0])
/// let ranges = spec2.domain.ranges
/// ```
/// A specification describing how random values should be generated.
///
/// This replaces the ambiguous `additionalParams` with a type-safe set of
/// named influences that call sites can extend using `InfluenceKey`.
public struct RandomisationSpec<T: BinaryFloatingPoint>: Hashable {

  /// Numeric bounds that define the domain for random value generation.
  public var domain: RandomDomain<T>

  /// Additional, named influences that may affect generation (e.g., smoothing,
  /// distribution skew, clamping policy). Values are type-safe per key.
  public var influences: [AnyInfluenceKey: AnyHashable]

  public init(
    domain: RandomDomain<T>,
    influences: [AnyInfluenceKey: AnyHashable] = [:]
  ) {
    self.domain = domain
    self.influences = influences
  }

  /// Convenience for a single range.
  public init(
    range: ClosedRange<T>,
    influences: [AnyInfluenceKey: AnyHashable] = [:]
  ) {
    self.init(domain: .single(range), influences: influences)
  }

  /// Convenience for multiple ranges.
  public init(
    ranges: [ClosedRange<T>],
    influences: [AnyInfluenceKey: AnyHashable] = [:]
  ) {
    self.init(domain: .multiple(ranges), influences: influences)
  }
}

extension RandomisationSpec {

  /// Read a typed influence value for a given key.
  public func influence<Value>(for key: InfluenceKey<Value>) -> Value? {
    influences[AnyInfluenceKey(key)] as? Value
  }

  /// Set a typed influence value for a given key.
  public mutating func setInfluence<Value>(_ value: Value, for key: InfluenceKey<Value>)
  where Value: Hashable {
    influences[AnyInfluenceKey(key)] = AnyHashable(value)
  }
}
