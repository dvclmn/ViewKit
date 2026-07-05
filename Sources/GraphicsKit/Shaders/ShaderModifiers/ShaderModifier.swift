//
//  AnimatedShaderModifier.swift
//  BaseComponents
//
//  Created by Dave Coleman on 12/8/2025.
//

import SwiftUI

public struct ShaderModifier: ViewModifier {

  let effect: ShaderEffect?
  let maxOffset: CGSize
  let isEnabled: Bool

  public func body(content: Content) -> some View {
    let application = ShaderEffectApplication(effect: effect)

    content
      .colorEffect(
        application.colourShader,
        isEnabled: isEnabled && application.isColourEffect,
      )
      .distortionEffect(
        application.distortionShader,
        maxSampleOffset: maxOffset,
        isEnabled: isEnabled && application.isDistortionEffect,
      )
      .layerEffect(
        application.layerShader,
        maxSampleOffset: maxOffset,
        isEnabled: isEnabled && application.isLayerEffect,
      )
  }
}

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
