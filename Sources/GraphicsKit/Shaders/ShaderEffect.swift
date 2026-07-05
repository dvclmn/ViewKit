//
//  Model+Effect.swift
//  BaseComponents
//
//  Created by Dave Coleman on 13/8/2025.
//

import CasePaths
import ColourTools
import CoreTools
import EnumMacros
import SwiftUI
import ViewTools

@MetaEnum
@CaseDetection
@CasePathable
@dynamicMemberLookup
public enum ShaderEffect: Sendable, Codable, Hashable, Identifiable {
  /// Horizontal red/blue channel separation.
  ///
  /// `strength` blends between the original colour and the separated colour.
  /// `channelSeparation` is the base horizontal sample distance in pixels.
  /// `radialStrength` increases that distance towards the edge of the layer.
  case chromaticAberration(
    strength: CGFloat,
    radialStrength: CGFloat,
    channelSeparation: CGFloat = 1,
  )
  case fisheye(
    origin: CGPoint,
    radius: CGFloat,
    strength: CGFloat,
  )

  case glitter(spread: CGFloat)

  /// Strength: Suggested range: -0.1 to -0.4
  /// Zoom: Suggested range: 1.0 to 1.1 (to hide edges)
  case crtCurvature(strength: CGFloat = 0.5)

  /// Distance between scanlines (e.g., 3.0)
  /// Darkening strength (0.0 to 1.0)
  /// Width of the vertical grille (e.g., 2.0),
  /// Final gain to offset dark lines (e.g., 1.2)
  case crtLines(
    lineSpacing: CGFloat = 1.0,
    lineIntensity: CGFloat = 1.0,
    phosphorSize: CGFloat = 1.0,
    brightness: CGFloat = 1.0,
  )

  /// Zoom-style blur that ramps by normalised radial distance from `origin`.
  ///
  /// `origin` is a normalised offset from the layer centre, so `.zero` keeps the
  /// blur centred. `start` is the distance where blur begins, and `end` is the
  /// distance where it reaches full strength.
  case radialBlur(
    origin: CGPoint,
    strength: CGFloat,
    start: CGFloat,
    end: CGFloat,
    samples: CGFloat,
  )

  case filmGrain(
    time: CGFloat,
    size: CGFloat,
    intensity: CGFloat,
    colour: CGFloat,
  )

  case ripplePush(
    location: CGPoint,
    velocity: CGPoint,
  )

  case psych(time: CGFloat)

  case checkerboard(
    primary: RGBColour = .white,
    secondary: RGBColour = .gray,
    scale: CGFloat = 4.0,
    offset: CGPoint = .zero,
  )

  //  case noShader
}

extension ShaderEffect {

  private static let defaultChromaticChannelSeparation: CGFloat = 1

  public var arguments: [Shader.Argument] {
    switch self {
      case .chromaticAberration(let strength, let radialStrength, let channelSeparation):
        [
          .boundingRect,
          .float(strength),
          .float(radialStrength),
          .float(channelSeparation),
        ]

      case .fisheye(let origin, let radius, let strength):
        [.boundingRect, .float2(origin), .float(radius), .float(strength)]

      case .glitter(let spread):
        [.boundingRect, .float(spread)]

      case .crtCurvature(let strength):
        [.boundingRect, .float(strength)]

      case .crtLines(let lineSpacing, let lineIntensity, let phosphorSize, let brightness):
        [
          .boundingRect,
          .float(lineSpacing),
          .float(lineIntensity),
          .float(phosphorSize),
          .float(brightness),
        ]

      case .radialBlur(let origin, let strength, let start, let end, let samples):
        [
          .boundingRect,
          .float2(origin),
          .float(strength),
          .float(start),
          .float(end),
          .float(samples),
        ]

      case .ripplePush(let location, let velocity):
        [.float2(location), .float2(velocity)]

      case .psych(let time):
        [.boundingRect, .float(time)]

      case .filmGrain(let time, let size, let intensity, let colour):
        [.float(time), .float(size), .float(intensity), .float(colour)]

      case .checkerboard(let primary, let secondary, let scale, let offset):
        [
          .boundingRect,
          .color(primary.toColour),
          .color(secondary.toColour),
          .float(scale),
          .float2(offset),
        ]

    }
  }
}
extension ShaderEffect {

  /// This refers to the name of the function in the `.metal` shader file.
  /// E.g. "chromaticAberration" refers to:
  /// ```
  /// [[ stitchable ]]
  /// half4 chromaticAberration(float2 position...)
  /// ```
  public var reference: (shader: String, name: String) {
    switch self {
      case .chromaticAberration: ("chromaticAberration", "Chromatic Aberration")
      case .fisheye: ("fisheye", "Fish-eye")
      case .glitter: ("glitter", "Glitter")
      case .crtCurvature: ("crtCurvature", "CRT Curvature")
      case .crtLines: ("crtLines", "CRT Lines")
      case .radialBlur: ("radialBlur", "Radial Blur")  // Also radialBlurFast
      case .ripplePush: ("ripplePush", "Ripple Push")
      case .psych: ("psych", "Pysch")
      case .filmGrain: ("filmGrain", "Film Grain")
      case .checkerboard: ("checkerboard", "Checkerboard")
    //      case .noShader: ("noShader", "No shader")
    }
  }

  /// Using the reference as the ID ensures that 'fisheye'
  /// is always the same 'item' in a ForEach, regardless of its settings.
  public var id: String { reference.shader }

  /// Custom Hashable to ensure "one of each" in a Set
  public func hash(into hasher: inout Hasher) {
    hasher.combine(reference.shader)
  }

  public static func == (lhs: ShaderEffect, rhs: ShaderEffect) -> Bool {
    lhs.reference == rhs.reference
  }

  public var shader: Shader {
    return Shader(
      function: ShaderFunction(
        library: .bundle(.module),
        name: reference.shader,
      ),
      arguments: arguments,
    )
  }
}
