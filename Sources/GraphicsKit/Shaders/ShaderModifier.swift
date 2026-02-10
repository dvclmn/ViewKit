//
//  AnimatedShaderModifier.swift
//  BaseComponents
//
//  Created by Dave Coleman on 12/8/2025.
//

import SwiftUI

@available(macOS 14, iOS 17, *)
public struct ShaderModifier: ViewModifier {

  let effect: ShaderEffect?
  let maxOffset: CGSize
  let isEnabled: Bool

  public func body(content: Content) -> some View {

    if #available(macOS 15, iOS 18, *), let effect {

      switch effect.usageType {

        case .colorEffect: content.colorEffect(
          effect.shader,
          isEnabled: isEnabled
        )

        case .distortionEffect:
          content.distortionEffect(
            effect.shader,
            maxSampleOffset: maxOffset,
            isEnabled: isEnabled
          )

        case .layerEffect: content.layerEffect(
          effect.shader,
          maxSampleOffset: maxOffset,
          isEnabled: isEnabled
        )

        default: content
      }

    } else {
      content
    }
  }
}

@available(macOS 14, iOS 17, *)
extension View {
  public func shaderEffect(
    _ effect: ShaderEffect?,
    isEnabled: Bool = true
  ) -> some View {
    self.modifier(
      ShaderModifier(
        effect: effect,
        maxOffset: .zero,
        isEnabled: isEnabled
      )
    )
  }

  public func shaderEffect(
    _ effect: ShaderEffect?,
    maxOffset: CGSize,
    isEnabled: Bool = true
  ) -> some View {
    self.modifier(
      ShaderModifier(
        effect: effect,
        maxOffset: maxOffset,
        isEnabled: isEnabled
      )
    )
  }
}
