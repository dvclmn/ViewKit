//
//  ShaderEffect+SampleOffset.swift
//  ViewKit
//
//  Created by Codex on 5/7/2026.
//

import CoreGraphics

extension ShaderEffect {
  public func maximumSampleOffset(for size: CGSize) -> CGSize {
    switch self {
      case .chromaticAberration(_, let radialStrength, let channelSeparation):
        let identity = CGFloat(1)
        let multiplier = max(identity, abs(identity + radialStrength))
        return Self.squareSampleOffset(abs(channelSeparation) * multiplier)

      case .radialBlur(_, let strength, _, _, _):
        let shortestSide = max(0, min(size.width, size.height))
        return Self.squareSampleOffset(abs(strength) * shortestSide * 0.5)

      default:
        return .zero
    }
  }

  public static func maximumSampleOffset<S: Sequence>(
    for effects: S,
    in size: CGSize,
  ) -> CGSize where S.Element == ShaderEffect {
    effects
      .map { $0.maximumSampleOffset(for: size) }
      .reduce(.zero) { current, offset in
        CGSize(
          width: max(current.width, offset.width),
          height: max(current.height, offset.height),
        )
      }
  }

  private static func squareSampleOffset(_ value: CGFloat) -> CGSize {
    CGSize(width: value, height: value)
  }
}
