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

  case glitter(spread: CGFloat,)

  case crtCurvature(distortion: CGFloat = 0.05)
  case crtLines(density: CGFloat = 1.5)

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

      case .crtCurvature(let distortion):
        [.boundingRect, .float(distortion)]

      case .crtLines(let density):
        [.boundingRect, .float(density)]

      case .ripplePush(let location, let velocity):
        [.float2(location), .float2(velocity)]

      case .psych(let time):
        [.boundingRect, .float(time)]

      case .filmGrain(let time, let size, let intensity, let colour):
        [.float(time), .float(size), .float(intensity), .float(colour)]
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
      case .ripplePush: ("ripplePush", "Ripple Push")
      case .psych: ("psych", "Pysch")
      case .filmGrain: ("filmGrain", "Film Grain")
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
