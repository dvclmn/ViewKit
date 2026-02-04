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
//    viewSize: CGSize,
    strength: CGFloat,  // Aka opacity
    radialStrength: CGFloat,
  )
  case fisheye(
    origin: CGPoint,
    radius: CGFloat,
    strength: CGFloat
  )

  case glitter(
    origin: UnitPoint,
    spread: CGFloat,
    viewSize: CGSize
  )

  case filmGrain(
    time: CGFloat,
    size: CGFloat,
    intensity: CGFloat,
    colour: CGFloat
  )

  case ripplePush(
    l: CGPoint,
    v: CGPoint
  )

  case psych(
    time: CGFloat
  )
}

extension ShaderEffect {
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

      case .glitter(let origin, let spread, let viewSize):
        [.float2(origin.toCGPoint(in: viewSize)), .float(spread)]

      case .ripplePush(let l, let v):
        [.float2(l), .float2(v)]

      case .psych(let time):
        [.boundingRect, .float(time)]

      case .filmGrain(let time, let size, let intensity, let colour):
        [.float(time), .float(size), .float(intensity), .float(colour)]
    }
  }
}
extension ShaderEffect {
  //  case filmGrain
  //  case wavyBlur
  //  case ripple
  //  case psych

  /// This refers to the name of the function in the `.metal` shader file.
  /// E.g. "chromaticAberration" refers to:
  /// ```
  /// [[ stitchable ]]
  /// half4 chromaticAberration(float2 position...)
  /// ```
  public var reference: String {
    switch self {
      case .chromaticAberration: "chromaticAberration"
      case .fisheye: "fisheye"
      case .glitter: "glitter"
      case .ripplePush: "ripplePush"
      case .psych: "psych"
      case .filmGrain: "filmGrain"
    //      case .wavyBlur: "wavyBlur"
    //      case .ripple: "ripple"
    //      case .psych: "psych"
    }
  }

  //  public var meta: Self.Meta { ShaderEffect.Meta(self) }

  public var name: String {
    switch self {
      case .chromaticAberration: "Chromatic Abberation"
      case .fisheye: "Fish-eye"
      case .glitter: "Glitter"
      case .ripplePush: "Ripple Push"
      case .psych: "Psych"
      case .filmGrain: "Film Grain"
    }
  }

  /// Using the reference as the ID ensures that 'fisheye'
  /// is always the same 'item' in a ForEach, regardless of its settings.
  public var id: String { reference }

  /// Custom Hashable to ensure "one of each" in a Set
  public func hash(into hasher: inout Hasher) {
    hasher.combine(reference)
  }

  public static func == (lhs: ShaderEffect, rhs: ShaderEffect) -> Bool {
    lhs.reference == rhs.reference
  }

  public var shader: Shader {
    return Shader(
      function: ShaderFunction(
        library: .bundle(.module),
        name: reference
      ),
      arguments: arguments
    )
  }

  /// Tip: `colorEffect` operates on individual pixel colors in isolation, whereas
  /// `layerEffect` provides access to the entire view layer, making it possible
  /// to sample neighboring pixels. Hence the `maxOffset` parameter.
  ///
  /// Shader function signatures for usage type.
  /// All assume `[[ stitchable ]]` is already included.
  ///
  /// ## layerEffect:
  /// ```
  /// half4 name(
  ///   float2 position,
  ///   SwiftUI::Layer layer,
  ///   args...
  /// )
  /// ```
  ///
  /// ## colorEffect:
  /// ```
  /// half4 name(
  ///   float2 position,
  ///   half4 color,
  ///   args...
  /// )
  /// ```
  ///
  /// ## distortionEffect:
  /// ```
  /// float2 name(
  ///   float2 position,
  ///   args...
  /// )
  /// ```
  @available(macOS 15.0, iOS 18.0, *)
  public var usageType: Shader.UsageType {
    switch self {
      case .chromaticAberration: .layerEffect
      case .ripplePush: .distortionEffect
      case .fisheye: .distortionEffect
      case .glitter: .layerEffect
      case .psych: .colorEffect
      case .filmGrain: .colorEffect
    }
  }
}
