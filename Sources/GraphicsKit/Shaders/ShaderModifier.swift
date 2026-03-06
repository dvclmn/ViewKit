//
//  AnimatedShaderModifier.swift
//  BaseComponents
//
//  Created by Dave Coleman on 12/8/2025.
//

import SwiftUI
import BasePrimitives

public struct ShaderModifier: ViewModifier {

  let effect: ShaderEffect?
  let maxOffset: CGSize
  let isEnabled: Bool

  public func body(content: Content) -> some View {

    if #available(macOS 15, iOS 18, *), let effect {

      switch effect.usageType {

        case .colorEffect:
          content.colorEffect(
            effect.shader,
            isEnabled: isEnabled
          )

        case .distortionEffect:
          content.distortionEffect(
            effect.shader,
            maxSampleOffset: maxOffset,
            isEnabled: isEnabled
          )

        case .layerEffect:
          content.layerEffect(
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

//@available(macOS 14, iOS 17, *)
//public struct ShaderStackModifier: ViewModifier {
//  let effects: [ShaderEffect]
//  let maxOffset: CGSize
//  let isEnabled: Bool
//
//  public func body(content: Content) -> some View {
//    // Apply effects in-order, avoiding AnyView by using a local builder function
//    apply(effects: effects, to: content)
//  }
//
//  @ViewBuilder
//  private func apply<V: View>(effects: [ShaderEffect], to base: V) -> some View {
//    // Early-outs
////    guard !effects.isEmpty else { base }
//
//    if #available(macOS 15, iOS 18, *) {
//      // Iteratively chain modifiers without type erasure by threading the view through
//      effects.reduce(base as some View) { partial, effect in
//        switch effect.usageType {
//        case .colorEffect:
//          partial.colorEffect(effect.shader, isEnabled: isEnabled)
//        case .distortionEffect:
//          partial.distortionEffect(effect.shader, maxSampleOffset: maxOffset, isEnabled: isEnabled)
//        case .layerEffect:
//          partial.layerEffect(effect.shader, maxSampleOffset: maxOffset, isEnabled: isEnabled)
//        default:
//          partial
//        }
//      }
//    } else {
//      base
//    }
//  }
//}
//@available(macOS 14, iOS 17, *)
//extension View {
//  public func shaderEffects(
//    _ effects: [ShaderEffect],
//    isEnabled: Bool = true
//  ) -> some View {
//    modifier(
//      ShaderStackModifier(
//        effects: effects,
//        maxOffset: .zero,
//        isEnabled: isEnabled
//      )
//    )
//  }
//
//  public func shaderEffects(
//    _ effects: [ShaderEffect],
//    maxOffset: CGSize,
//    isEnabled: Bool = true
//  ) -> some View {
//    modifier(
//      ShaderStackModifier(
//        effects: effects,
//        maxOffset: maxOffset,
//        isEnabled: isEnabled
//      )
//    )
//  }
//}

