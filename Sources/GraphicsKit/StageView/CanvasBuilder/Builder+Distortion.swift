//
//  Builder+Warp.swift
//  BaseDemos
//
//  Created by Dave Coleman on 3/2/2026.
//

import CasePaths
import Foundation

/// `strength`
/// Controls how aggressively the below `depth` is applied
///
/// `depth`
/// Distance to projection plane / camera
/// Basically, how far away is the 'camera', from the geometry
@CasePathable
@dynamicMemberLookup
public enum DistortionModel: Codable, Sendable, Equatable, Hashable {
  /// The original one — `scale = 1 / (1 + k*r))`
  case radialProjective(strength: CGFloat)

  /// classic lens distortion family (k1, k2, ...)
  case radialPolynomial(strength: CGFloat)
  case planarPerspective(strength: CGFloat)
  case none

  public static let radialDefault: Self = .radialProjective(strength: 0.5)
}

extension DistortionModel {
  public var strengthValue: CGFloat? {
    switch self {
      case .radialProjective(let strength): strength
      case .radialPolynomial(let strength): strength
      case .planarPerspective(let strength): strength
      case .none: nil
    }
  }

  var strengthRange: ClosedRange<CGFloat> { -2.5...2.5 }

  /// This is worth keeping as an internal constant, as the strength
  /// factor simply adjusts against this. Keeping this stable allows
  /// calibrating only one single value, instead of juggling two sliders
  var depthConstant: CGFloat { 300 }
}

extension DistortionModel {

  package func distort(
    _ p: CGPoint,
    vanishingPoint: CGPoint
  ) -> CGPoint {
    switch self {
      case .radialProjective(let strength):
        return applyRadialProjectiveWarp(
          point: p,
          vanishingPoint: vanishingPoint,
          strength: strength,
          depth: depthConstant
        )

      /// Not yet implemented
      case .radialPolynomial, .planarPerspective, .none:
        print("\(self) Not yet implemented")
        return p
    }
  }

  /// Apply perspective projection to a point
  /// `vanishingPoint` should be absolute, so relative to the
  /// local coordinate space, not a `UnitPoint`.
  public func applyRadialProjectiveWarp(
    point: CGPoint,
    vanishingPoint: CGPoint,
    strength: CGFloat,
    depth: CGFloat
  ) -> CGPoint {

    /// Vector from vanishing point to the point
    let dx = point.x - vanishingPoint.x
    let dy = point.y - vanishingPoint.y

    /// Distance from vanishing point
    let distance = sqrt(dx * dx + dy * dy)

    /// Avoid division by zero
    guard distance > 0.001 else { return point }

    /// Perspective scaling factor
    /// The farther from the vanishing point, the larger it appears
    /// This uses a simple perspective projection formula
    let z = distance / depth
    let denom = 1.0 + strength * z

    /// Avoid singularities and inverted scale
    let epsilon: CGFloat = 1e-3
    let safeDenom = max(denom, epsilon)
    let scale = 1.0 / safeDenom

    /// Apply the scale, interpolating toward the vanishing point
    return CGPoint(
      x: vanishingPoint.x + dx * scale,
      y: vanishingPoint.y + dy * scale
    )
  }
}
