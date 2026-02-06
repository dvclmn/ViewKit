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
/// let ranges = spec2.bounds.ranges
/// ```
/// A type-safe key for influencing random generation beyond numeric bounds.
///
/// Create static keys in extensions to add new influences without colliding names.
public struct InfluenceKey<Value: Hashable>: Hashable, ExpressibleByStringLiteral, CustomStringConvertible {
  public let rawValue: String
  public init(_ rawValue: String) { self.rawValue = rawValue }
  public init(stringLiteral value: String) { self.rawValue = value }
  public var description: String { rawValue }
}

/// Expresses the numeric domain from which random values may be drawn.
/// Use a single closed range for simple cases, or multiple disjoint ranges to
/// construct a composite domain.
public enum Bounds<T: BinaryFloatingPoint>: Hashable {
  case single(ClosedRange<T>)
  case multiple([ClosedRange<T>])

  /// Flattens to an array of ranges for algorithms that operate over sequences.
  public var ranges: [ClosedRange<T>] {
    switch self {
    case .single(let r): return [r]
    case .multiple(let rs): return rs
    }
  }
}
/// A specification describing how random values should be generated.
///
/// This replaces the ambiguous `additionalParams` with a type-safe set of
/// named influences that call sites can extend using `InfluenceKey`.
public struct RandomizationSpec<T: BinaryFloatingPoint>: Hashable {

  /// Numeric bounds that define the domain for random value generation.
  public var bounds: Bounds<T>

  /// Additional, named influences that may affect generation (e.g., smoothing,
  /// distribution skew, clamping policy). Values are type-safe per key.
  public var influences: [AnyInfluenceKey: AnyHashable]

  /// Type-erased key wrapper to keep `influences` dictionary heterogeneous while
  /// preserving key identity and hashing.
  public struct AnyInfluenceKey: Hashable, CustomStringConvertible {
    private let box: AnyHashable
    private let _description: () -> String
    public init<Value>(_ key: InfluenceKey<Value>) {
      self.box = AnyHashable(key.rawValue)
      self._description = { key.rawValue }
    }
    public var description: String { _description() }
  }

  public init(bounds: Bounds<T>, influences: [AnyInfluenceKey: AnyHashable] = [:]) {
    self.bounds = bounds
    self.influences = influences
  }

  /// Convenience for a single range.
  public init(range: ClosedRange<T>, influences: [AnyInfluenceKey: AnyHashable] = [:]) {
    self.init(bounds: .single(range), influences: influences)
  }

  /// Convenience for multiple ranges.
  public init(ranges: [ClosedRange<T>], influences: [AnyInfluenceKey: AnyHashable] = [:]) {
    self.init(bounds: .multiple(ranges), influences: influences)
  }

  /// Read a typed influence value for a given key.
  public func influence<Value>(for key: InfluenceKey<Value>) -> Value? {
    influences[AnyInfluenceKey(key)] as? Value
  }

  /// Set a typed influence value for a given key.
  public mutating func setInfluence<Value>(_ value: Value, for key: InfluenceKey<Value>) where Value: Hashable {
    influences[AnyInfluenceKey(key)] = AnyHashable(value)
  }
}

// MARK: - Migration aids

/// Backwards-compatible alias so existing call sites compile while migrating.
public typealias RandomisationParameters<T: BinaryFloatingPoint> = RandomizationSpec<T>

public extension RandomizationSpec {
  /// Legacy-style initializer to ease migration from `ranges` + `additionalParams`.
  init(ranges: [ClosedRange<T>] = [], additionalParams: [String: AnyHashable] = [:]) {
    let bounds: Bounds<T> = ranges.count == 1 ? .single(ranges[0]) : .multiple(ranges)
    var influences: [AnyInfluenceKey: AnyHashable] = [:]
    // Map legacy string keys into InfluenceKey<String> for continuity.
    for (k, v) in additionalParams { influences[AnyInfluenceKey(InfluenceKey<String>(k))] = v }
    self.init(bounds: bounds, influences: influences)
  }
}

// MARK: - Common influence keys

public extension InfluenceKey where Value == Double {
  /// Bias/skew factor in the range [-1, 1], where 0 is uniform.
  static var skew: InfluenceKey<Double> { "skew" }
}

public extension InfluenceKey where Value == Bool {
  /// Whether to favor continuity between successive values.
  static var smoothTransitions: InfluenceKey<Bool> { "smoothTransitions" }
}

