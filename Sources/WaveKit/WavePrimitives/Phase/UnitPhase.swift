//
//  UnitPhase.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 14/2/2026.
//

import Foundation

public struct UnitPhase<T: WaveFloat>: Sendable, Hashable, Codable {

  /// Always wrapped to [0, 1)
  public private(set) var turns: T

  public init(_ turns: T) { self.turns = Self.wrap(turns) }

  public init(from decoder: any Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.init(try container.decode(T.self, forKey: .turns))
  }

  public mutating func advance(by dTurns: T) {
    turns = Self.wrap(turns + dTurns)
  }

  @inline(__always) public static func wrap(_ u: T) -> T {
    let y = u - floor(u)
    return y < 0 ? y + 1 : y
  }

  @inline(__always) public var radians: T { turns * T.twoPi }

  private enum CodingKeys: String, CodingKey {
    case turns
  }
}

extension BinaryFloatingPoint {
  /// For the latest regarding wrapping phase, see `VectorKit/WaveKit/Core`
  /// Could also be called `normalisedCycles`?
  /// Corrects negative phases and floating-point overflow
  /// `floor` returns the greatest integer less than or equal to `phase`
  /// `phase - floor(phase)` computes the fractional part of phase.
  ///
  /// - If phase is positive (e.g., `2.75`), `floor(2.75) = 2`, so `p = 0.75`
  /// - If phase is negative (e.g., `−0.25`), `floor(−0.25) = −1`,
  ///   so `p = −0.25 − (−1) = 0.75`. This effectively “wraps”
  ///   negative phases into the [0, 1) interval.
  /// - If phase is an integer (e.g., `3.0`), `p = 0.0`.
  //  @inlinable
  //  public static func normalisedPhase(_ phase: Self) -> Self {
  //    let p = phase - floor(phase)
  //
  //    /// Clamp 1.0 to 0.0 (rare, but possible with floating point error)
  //    return p >= 1.0 ? 0 : p
  //  }
  //
  //  @inlinable
  //  public static func normalisedRadians(_ radians: Self) -> Self {
  //    let tau = Self.pi * 2
  //    let r = radians.truncatingRemainder(dividingBy: tau)
  //
  //    // Map negative values into [0, 2π)
  //    let p = r >= 0 ? r : r + tau
  //
  //    /// Clamp 2π to 0 (possible with FP error)
  //    return p >= tau ? 0 : p
  //  }

}
