//
//  ZoomComputation.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 19/3/2026.
//

import SwiftUI

/// Shared utilities for mapping pointer deltas to multiplicative zoom factors.
///
/// The mapping is linear-to-multiplicative: factor = 1 + contribution / sensitivity
/// with a minimum floor to keep the factor positive and stable.
///
/// Choose weights to control how horizontal and vertical movement contribute:
/// - `.upRight`: right (+x) and up (-y) increase zoom; left and down decrease.
/// - `.vertical`: down (+y) increases zoom; up decreases (matches existing swipe behavior).
enum ZoomComputation {

  // MARK: Axis Weights
  struct Weights {
    let x: CGFloat
    let y: CGFloat
    
    /// Right (+x) and up (-y) increase zoom.
    static let upRight = Weights(x: 1, y: -1)
    /// Vertical-only: down (+y) increases zoom, up decreases.
    static let vertical = Weights(x: 0, y: 1)
  }


  // MARK: Factor computation

  /// Compute a multiplicative zoom factor from a delta in points.
  /// - Parameters:
  ///   - delta: A CGSize delta in screen space.
  ///   - weights: Axis contribution weights.
  ///   - sensitivity: Larger = gentler; `1 / sensitivity` is the per-point zoom change.
  ///   - minFactor: Lower bound to keep factor positive.
  /// - Returns: A positive factor suitable for multiplicative scaling.
  static func factorFromDelta(
    _ delta: CGSize,
    weights: Weights = .upRight,
    sensitivity: CGFloat = 200,
    minFactor: CGFloat = 0.1
  ) -> CGFloat {
    let contribution = (delta.width * weights.x) + (delta.height * weights.y)
    let raw = 1.0 + (contribution / sensitivity)
    return max(raw, minFactor)
  }

  /// Compute a multiplicative zoom factor from two points (from → to).
  static func factorFromPoints(
    from: CGPoint,
    to: CGPoint,
    weights: Weights = .upRight,
    sensitivity: CGFloat = 200,
    minFactor: CGFloat = 0.1
  ) -> CGFloat {
    let delta = CGSize(width: to.x - from.x, height: to.y - from.y)
    return factorFromDelta(delta, weights: weights, sensitivity: sensitivity, minFactor: minFactor)
  }
}
