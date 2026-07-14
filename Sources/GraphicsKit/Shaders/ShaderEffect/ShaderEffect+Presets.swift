//
//  ShaderEffect+PresetKind.swift
//  ViewKit
//
//  Created by Dave Coleman on 14/7/2026.
//

import CoreGraphics
import Foundation

extension ShaderEffect {
  /// The visual emphasis used when creating an example effect with ``preset(_:kind:in:time:)``.
  public enum PresetKind: String, CaseIterable, Codable, Hashable, Sendable {
    /// A restrained example suited to stacking with other effects.
    case subtle

    /// A more obvious example that makes the effect easy to inspect in isolation.
    case pronounced
  }
}

extension ShaderEffect {

  /// Creates a ready-to-use example of an effect.
  ///
  /// Every effect has a ``PresetKind/subtle`` and ``PresetKind/pronounced``
  /// variant. Most variants change visual intensity; effects without an
  /// intensity control use the kind to vary their scale, motion, or phase.
  ///
  /// Pass the rendered size when using an effect with pixel-space geometry,
  /// such as ``fisheye(origin:radius:strength:)`` or
  /// ``ripplePush(location:velocity:)``. The default represents a small
  /// 300-point example canvas. Animated effects remain deterministic by using
  /// the caller-supplied `time` value.
  ///
  /// ```swift
  /// let blur = ShaderEffect.preset(.radialBlur, kind: .subtle)
  /// let fisheye = ShaderEffect.preset(.fisheye, kind: .pronounced, in: size)
  /// let grain = ShaderEffect.preset(.filmGrain, time: elapsedTime)
  /// ```
  public static func preset(
    _ effect: Meta,
    kind: PresetKind = .subtle,
    in size: CGSize = .init(width: 300, height: 300),
    time: CGFloat = 0,
  ) -> Self {
    let centre = CGPoint(
      x: max(0, size.width) * 0.5,
      y: max(0, size.height) * 0.5,
    )

    return switch (effect, kind) {
      case (.chromaticAberration, .subtle):
        .chromaticAberration(
          strength: 0.35,
          radialStrength: 2,
          channelSeparation: 0.75,
        )
      case (.chromaticAberration, .pronounced):
        .chromaticAberration(
          strength: 0.85,
          radialStrength: 6,
          channelSeparation: 1.5,
        )

      case (.fisheye, .subtle):
        .fisheye(origin: centre, radius: 1, strength: 0.25)
      case (.fisheye, .pronounced):
        .fisheye(origin: centre, radius: 1, strength: 0.7)

      case (.glitter, .subtle):
        .glitter(spread: 0.25)
      case (.glitter, .pronounced):
        .glitter(spread: 1.25)

      case (.crtCurvature, .subtle):
        .crtCurvature(strength: 0.15)
      case (.crtCurvature, .pronounced):
        .crtCurvature(strength: 0.5)

      case (.crtLines, .subtle):
        .crtLines(
          lineSpacing: 2,
          lineIntensity: 0.25,
          phosphorSize: 2,
          brightness: 1.1,
        )
      case (.crtLines, .pronounced):
        .crtLines(
          lineSpacing: 4,
          lineIntensity: 0.65,
          phosphorSize: 4,
          brightness: 1.55,
        )

      case (.radialBlur, .subtle):
        .radialBlur(
          origin: .zero,
          strength: 0.025,
          start: 0.65,
          end: 1,
          samples: 20,
        )
      case (.radialBlur, .pronounced):
        .radialBlur(
          origin: .zero,
          strength: 0.08,
          start: 0.35,
          end: 0.9,
          samples: 32,
        )

      case (.filmGrain, .subtle):
        .filmGrain(time: time, size: 0.9, intensity: 0.08, colour: 0)
      case (.filmGrain, .pronounced):
        .filmGrain(time: time, size: 2, intensity: 0.22, colour: 0.25)

      case (.ripplePush, .subtle):
        .ripplePush(
          location: centre,
          velocity: CGPoint(x: size.width * 0.06, y: -size.height * 0.02),
        )
      case (.ripplePush, .pronounced):
        .ripplePush(
          location: centre,
          velocity: CGPoint(x: size.width * 0.2, y: -size.height * 0.08),
        )

      case (.psych, .subtle):
        .psych(time: time * 0.35)
      case (.psych, .pronounced):
        .psych(time: time + 2.5)

      case (.checkerboard, .subtle):
        .checkerboard(
          primary: .gray,
          secondary: .grayAlt,
          scale: 16,
        )
      case (.checkerboard, .pronounced):
        .checkerboard(
          primary: .black,
          secondary: .white,
          scale: 6,
        )
    }
  }
}

// MARK: - Older presets
extension ShaderEffect {
  public static let chromaticPresetA: ShaderEffect = .chromaticAberration(
    strength: 1.6,
    radialStrength: 3.0,
    channelSeparation: 1,
  )

  public static let chromaticSubtle: ShaderEffect = .chromaticAberration(
    strength: 0.95,
    radialStrength: 1.5,
    channelSeparation: 1,
  )

  public static let fisheyePresetA: ShaderEffect = .fisheye(
    origin: CGPoint(200, 300),
    radius: 10,
    strength: 2,
  )

  public static let psychPresetA: ShaderEffect = .psych(time: Date.now.timeIntervalSinceReferenceDate)
}
