//
//  ShaderUsageType.swift
//  ViewKit
//
//  Created by Dave Coleman on 10/2/2026.
//

import SwiftUI

extension ShaderEffect {

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
  ///
  /// ## shapeStyle:
  /// ```
  /// half4 name(float2 position, args...)
  /// ```
  @available(macOS 15.0, iOS 18.0, *)
  public var usageType: Shader.UsageType {
    switch self {
      case .chromaticAberration, .glitter, .radialBlur: .layerEffect
      case .ripplePush, .crtCurvature, .fisheye: .distortionEffect
      case .psych, .filmGrain, .crtLines: .colorEffect
      case .checkerboard: .shapeStyle
    }
  }
}
