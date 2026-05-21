//
//  VariedWidthLine.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 23/1/2026.
//

import SwiftUI

/// Common full-width profiles for variable-width paths.
public enum PathWidthProfile {
  case constant(CGFloat)
  case tapered(min: CGFloat, max: CGFloat)
  case custom((CGFloat) -> CGFloat)

  /// Returns the full stroke width at a normalised position from 0...1.
  public func width(at t: CGFloat) -> CGFloat {
    switch self {
      case .constant(let width):
        return width

      case .tapered(let min, let max):
        let envelope = sin(t * .pi)
        return min + (max - min) * envelope

      case .custom(let width):
        return width(t)
    }
  }
}

extension Path {

  public static func variableWidthPath(
    spine: Path,
    profile: PathWidthProfile,
    samples: Int,
    normalStrategy: VariableWidthPath.NormalStrategy = .rotating,
    usesSmoothCurves: Bool = true,
  ) -> Path {
    Self.variableWidthPath(
      spine: spine,
      widthAt: { profile.width(at: $0) },
      samples: samples,
      normalStrategy: normalStrategy,
      usesSmoothCurves: usesSmoothCurves
    )
  }

  /// Creates a closed path with variable width along a spine path.
  ///
  /// This samples the spine path and feeds those samples through
  /// ``VariableWidthPath`` so the path-based and streaming APIs share the same
  /// outline construction logic.
  ///
  /// - Parameters:
  ///   - spine: The centre path to follow.
  ///   - widthAt: Closure that returns the full width at a normalised position
  ///     from 0...1.
  ///   - samples: Number of samples along the path. Values below 1 are
  ///     clamped to 1.
  ///   - normalStrategy: Strategy used to derive outline normals.
  ///   - usesSmoothCurves: Whether the generated outline edges use quadratic
  ///     curves through midpoints.
  /// - Returns: A closed path that can be filled.
  private static func variableWidthPath(
    spine: Path,
    widthAt: @escaping (CGFloat) -> CGFloat,
    samples: Int,
    normalStrategy: VariableWidthPath.NormalStrategy,
    usesSmoothCurves: Bool,
  ) -> Path {
    let sampleCount = max(1, samples)
    var outline = VariableWidthPath(
      normalStrategy: normalStrategy,
      widthSmoothing: 0
    )

    for i in 0...sampleCount {
      let t = CGFloat(i) / CGFloat(sampleCount)
      let trimmedPath = spine.trimmedPath(from: 0, to: max(0.0001, t))

      guard let point = trimmedPath.currentPoint else {
        continue
      }

      outline.addPoint(to: point, rawWidth: widthAt(t))
    }

    return outline.generatePath(usesSmoothCurves: usesSmoothCurves)
  }
}
