//
//  ShaderEffectApplication.swift
//  ViewKit
//
//  Created by Dave Coleman on 5/7/2026.
//

import SwiftUI

struct ShaderEffectApplication {
  let effect: ShaderEffect?

  var isColourEffect: Bool {
    effect?.applicationKind == .colourEffect
  }

  var isDistortionEffect: Bool {
    effect?.applicationKind == .distortionEffect
  }

  var isLayerEffect: Bool {
    effect?.applicationKind == .layerEffect
  }

  var colourShader: Shader {
    guard isColourEffect, let effect else {
      return ShaderEffect.passthroughColourShader
    }
    return effect.shader
  }

  var distortionShader: Shader {
    guard isDistortionEffect, let effect else {
      return ShaderEffect.passthroughDistortionShader
    }
    return effect.shader
  }

  var layerShader: Shader {
    guard isLayerEffect, let effect else {
      return ShaderEffect.passthroughLayerShader
    }
    return effect.shader
  }
}
