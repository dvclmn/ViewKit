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
    r: CGFloat,
    b: CGFloat,
    strength: CGFloat
  )
  case fisheye(
    size: CGFloat,
    strength: CGFloat
  )

  case glitter(
    origin: UnitPoint,
    spread: CGFloat,
    viewSize: CGSize
  )
}

extension ShaderEffect.Meta: Sendable, Codable {

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
    //      case .filmGrain: "filmGrain"
    //      case .wavyBlur: "wavyBlur"
    //      case .ripple: "ripple"
    //      case .psych: "psych"
    }
  }

  public var meta: Self.Meta { ShaderEffect.Meta(self) }

  public var name: String {
    switch self {
      case .chromaticAberration: "Chromatic Abberation"
      case .fisheye: "Fish-eye"
      case .glitter: "Glitter"
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

  public var arguments: [Shader.Argument] {

    switch self {
      /// Haven't yet exposed all shader controls to this case
      case .chromaticAberration(let r, let b, let strength):
        [
          .float(r),
          .float(-0.7),
          .float(b),
          .float(-0.7),
          .float(strength),
        ]

      case .fisheye(let size, let strength):
        [.float(size), .float(strength)]

      case .glitter(let origin, let spread, let viewSize):
        [.float2(origin.toCGPoint(in: viewSize)), .float(spread)]
    }

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
      case .fisheye: .distortionEffect
      case .glitter: .layerEffect
    }
  }
}

//extension Array where Element == ShaderEffect {
//  public func getEffect(of kind: Element.Meta) -> Element? {
//    first(where: { ShaderEffect.Meta($0) == kind })
//  }
//
////  public mutating func setEffect<T>(of kind: Element.Meta) -> Element? {
////    first(where: { ShaderEffect.Meta($0) == kind })
////  }
//}
