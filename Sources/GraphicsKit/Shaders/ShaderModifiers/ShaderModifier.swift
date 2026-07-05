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
