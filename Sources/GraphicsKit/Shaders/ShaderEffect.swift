//
//  Model+Effect.swift
//  BaseComponents
//
//  Created by Dave Coleman on 13/8/2025.
//

import SwiftUI

public enum ShaderEffect {
  case chromaticAberration(ChromaticAberrationArgs)
  case fisheye(FisheyeArgs)
//  case filmGrain
  //  case glitter(GlitterArgs)
  //  case wavyBlur
  //  case ripple
  //  case psych

  public var reference: String {
    switch self {
      case .chromaticAberration: "chromaticAberration"
      case .fisheye: "fisheye"
//      case .filmGrain: "filmGrain"
    //      case .wavyBlur: "wavyBlur"
    //      case .ripple: "ripple"
    //      case .psych: "psych"
    }
  }

  public var arguments: [Shader.Argument] {

    switch self {
      case .chromaticAberration(let args): args.arguments
      case .fisheye(let args): args.arguments
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
