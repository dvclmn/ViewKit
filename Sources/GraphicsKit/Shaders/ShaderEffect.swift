//
//  Model+Effect.swift
//  BaseComponents
//
//  Created by Dave Coleman on 13/8/2025.
//

import CoreTools
import SwiftUI

public enum ShaderEffect {
  case chromaticAberration(r: CGFloat, b: CGFloat, strength: CGFloat)
  //  case chromaticAberration(ChromaticAberrationArgs)
  case fisheye(size: CGFloat, strength: CGFloat)
  case glitter(origin: UnitPoint, spread: CGFloat, viewSize: CGSize)
  //  case fisheye(FisheyeArgs)
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

  public var arguments: [Shader.Argument] {

    switch self {
      case .chromaticAberration(let r, let g, let strength):
        [.float(r), .float(g), .float(strength)]

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

  /// Shader function signatures for usage type:
  ///
  /// ## `layerEffect`:
  /// ```
  /// [[ stitchable ]] half4 name(
  ///   float2 position,
  ///   SwiftUI::Layer layer,
  ///   args...
  /// )
  /// ```
  ///
  /// ## `colorEffect`:
  /// ```
  /// [[ stitchable ]] half4 name(
  ///   float2 position,
  ///   half4 color,
  ///   args...
  /// )
  /// ```
  ///
  /// ## `distortionEffect`:
  /// ```
  /// [[ stitchable ]] float2 name(
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

  /// Expected argument *types*, not values
  //  public var argumentTypes: [ShaderArgType] {
  //    switch self {
  //      case .chromaticAberration:
  //        return []
  //      case .glitter:
  //        return [.float]
  //      case .wavyBlur:
  //        return [.float, .float2]
  //      case .ripple:
  //        return [.float2, .float2]
  //    }
  //  }

  //  public var arguments: [ShaderArg] {
  //    switch self {
  //      case .chromaticAberration:
  //        []
  //      case .glitter:
  //
  //      case .wavyBlur:
  //        <#code#>
  //      case .ripple:
  //        <#code#>
  //    }
  //  }
}
