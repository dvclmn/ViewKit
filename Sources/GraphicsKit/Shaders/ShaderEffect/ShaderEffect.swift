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
  /// `channelSeparation` is the base horizontal sample distance in pixels, and
  /// `radialStrength` multiplies that distance as the sample position moves from
  /// the centre towards the layer bounds.
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

  /// Renders a reduced-resolution CRT signal through scanlines and an RGB
  /// aperture grille.
  ///
  /// `lineSpacing` is the physical height, in SwiftUI points, of a scanline
  /// period; `phosphorSize` is the width of an RGB triad. They also form the
  /// height and width of the virtual source cells, respectively, so the input
  /// view is sampled once per cell before the CRT structure is drawn. Keeping
  /// the two dimensions independent avoids assuming that scanlines and triads
  /// are the same size. `lineIntensity` controls the beam falloff between
  /// scanlines, while `brightness` compensates for the deliberate darkening.
  case crtLines(
    lineSpacing: CGFloat = 3.0,
    lineIntensity: CGFloat = 0.55,
    phosphorSize: CGFloat = 3.0,
    brightness: CGFloat = 1.35,
  )

  /// Zoom-style blur that ramps by normalised distance from `origin` to the layer bounds.
  ///
  /// `origin` is a normalised offset from the layer centre, so `.zero` keeps the
  /// blur centred. `strength` is a fraction of the layer's shortest side, `start`
  /// is the distance where blur begins, and `end` is the distance where it
  /// reaches full strength. `samples` is a quality factor rather than an exact
  /// count: the shader treats it as the nominal count for a 1,024-point shortest
  /// side, scales it with the view, and clamps the resulting count to `4...48`.
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
}

extension ShaderEffect {

  public var shader: Shader {
    Self.stitchableShader(named: reference.shader, arguments: arguments)
  }

  public var displayName: String { reference.name }

  /// Using the reference as the ID ensures that 'fisheye'
  /// is always the same 'item' in a ForEach, regardless of its settings.
  public var id: String { reference.shader }

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
    }
  }

  /// Custom Hashable to ensure "one of each" in a Set
  public func hash(into hasher: inout Hasher) {
    hasher.combine(reference.shader)
  }

  public static func == (lhs: ShaderEffect, rhs: ShaderEffect) -> Bool {
    lhs.reference == rhs.reference
  }

}

extension ShaderEffect {
  static func stitchableShader(
    named name: String,
    arguments: [Shader.Argument] = [],
  ) -> Shader {
    Shader(
      function: ShaderFunction(
        library: .bundle(.module),
        name: name,
      ),
      arguments: arguments,
    )
  }

  static var passthroughColourShader: Shader {
    stitchableShader(named: "passthroughColour")
  }

  static var passthroughDistortionShader: Shader {
    stitchableShader(named: "passthroughDistortion")
  }

  static var passthroughLayerShader: Shader {
    stitchableShader(named: "passthroughLayer")
  }
}
