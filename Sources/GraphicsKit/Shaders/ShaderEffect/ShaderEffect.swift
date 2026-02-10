//
//  Model+Effect.swift
//  BaseComponents
//
//  Created by Dave Coleman on 13/8/2025.
//

import CasePaths
import CoreTools
import SwiftUI

@MetaEnum
@CaseDetection
@CasePathable
@dynamicMemberLookup
public enum ShaderEffect: Sendable, Codable, Hashable, Identifiable {
  case chromaticAberration(
    strength: CGFloat,  // Aka opacity
    radialStrength: CGFloat,
  )
  case fisheye(
    origin: CGPoint,
    radius: CGFloat,
    strength: CGFloat
  )

  case glitter(spread: CGFloat, )

  case crtCurvature(
    strength: CGFloat,  // Suggested range: -0.1 to -0.4
    zoom: CGFloat  // Suggested range: 1.0 to 1.1 (to hide edges)
      //    k1: CGFloat,
      //    k2: CGFloat,
  )
  case crtLines(
    lineSpacing: CGFloat,  // Distance between scanlines (e.g., 3.0)
    lineIntensity: CGFloat,  // Darkening strength (0.0 to 1.0)
    phosphorSize: CGFloat,  // Width of the vertical grille (e.g., 2.0),
    brightness: CGFloat  // Final gain to offset dark lines (e.g., 1.2)
  )

  case radialBlur(
    origin: CGPoint,
    strength: CGFloat,
    start: CGFloat,
    end: CGFloat,
    samples: CGFloat
  )

  case filmGrain(
    time: CGFloat,
    size: CGFloat,
    intensity: CGFloat,
    colour: CGFloat
  )

  case ripplePush(
    location: CGPoint,
    velocity: CGPoint
  )

  case psych(
    time: CGFloat
  )

  //  case noShader
}

extension ShaderEffect {
  //  public var range: ClosedRange<CGFloat> {
  //    switch self {
  //      case .chromaticAberration:
  //      case .fisheye:
  //      case .glitter:
  //      case .crtCurvature:
  //      case .crtLines:
  //      case .filmGrain:
  //      case .ripplePush:
  //      case .psych:
  //    }
  //  }

  public var arguments: [Shader.Argument] {
    switch self {
      /// Haven't yet exposed all shader controls to this case
      case .chromaticAberration(let strength, let radialStrength):
        [
          .boundingRect,
          .float(strength),
          .float(radialStrength),
        ]

      case .fisheye(let origin, let radius, let strength):
        [.boundingRect, .float2(origin), .float(radius), .float(strength)]

      case .glitter(let spread):
        [.boundingRect, .float(spread)]

      case .crtCurvature(let strength, let zoom):
        [.boundingRect, .float(strength), .float(zoom)]

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

    //      case .noShader: []
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
      case .chromaticAberration: ("chromaticAberration", "Chromatic Abberation")
      case .fisheye: ("fisheye", "Fish-eye")
      case .glitter: ("glitter", "Glitter")
      case .crtCurvature: ("crtCurvature", "CRT Curvature")
      case .crtLines: ("crtLines", "CRT Lines")
      case .radialBlur: ("radialBlur", "Radial Blur")  // Also radialBlurFast
      case .ripplePush: ("ripplePush", "Ripple Push")
      case .psych: ("psych", "Pysch")
      case .filmGrain: ("filmGrain", "Film Grain")
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
        name: reference.shader
      ),
      arguments: arguments
    )
  }

}
