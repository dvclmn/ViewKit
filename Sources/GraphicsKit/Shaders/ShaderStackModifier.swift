//
//  ShaderStackModifier.swift
//  ViewKit
//
//  Created by Dave Coleman on 10/2/2026.
import CoreTools
import ViewTools
// import BaseTools
import SwiftUI

public struct ShaderStackModifier: ViewModifier {

  let shaders: [ShaderEffect]
  let maxOffset: CGSize

  public func body(content: Content) -> some View {
    content
      .shaderEffect(
        shaders[safe: 3],
        maxOffset: maxOffset,
        isEnabled: true
      )

      .shaderEffect(
        shaders[safe: 2],
        maxOffset: maxOffset,
        isEnabled: true
      )

      .shaderEffect(
        shaders[safe: 1],
        maxOffset: maxOffset,
        isEnabled: true
      )

      .shaderEffect(
        shaders[safe: 0],
        maxOffset: maxOffset,
        isEnabled: true
      )

  }
}
extension View {
  public func shaderStack(
    _ shaders: ShaderEffect...,
    maxOffset: CGSize? = nil
  ) -> some View {
    self.modifier(
      ShaderStackModifier(
        shaders: shaders,
        maxOffset: maxOffset ?? .zero
      )
    )
  }
  public func shaderStack(
    _ shaders: [ShaderEffect],
    maxOffset: CGSize? = nil
  ) -> some View {
    self.modifier(
      ShaderStackModifier(
        shaders: shaders,
        maxOffset: maxOffset ?? .zero
      )
    )
  }
}

//public struct ShaderStackModifier<Content: View>: View {
//  let content: Content
//  let effects: [ShaderEffect]
//  let maxOffset: CGSize
//  let isEnabled: Bool
//
//  public var body: some View {
//    applyEffects(to: content, effects: effects)
//  }
//
//  @ViewBuilder
//  private func applyEffects<V: View>(
//    to view: V,
//    effects: [ShaderEffect]
////    effects: ArraySlice<ShaderEffect>
//  ) -> some View {
//    if let first = effects.first {
//      let remaining = effects.dropFirst()
//      applyEffects(
//        to: applySingleEffect(to: view, effect: first),
//        effects: Array(remaining)
//      )
//    } else {
//      view
//    }
//  }
//
//  @ViewBuilder
//  private func applySingleEffect<V: View>(
//    to view: V,
//    effect: ShaderEffect
//  ) -> some View {
//    if #available(macOS 15, iOS 18, *) {
//      switch effect.usageType {
//        case .colorEffect:
//          view.colorEffect(effect.shader, isEnabled: isEnabled)
//        case .distortionEffect:
//          view.distortionEffect(
//            effect.shader,
//            maxSampleOffset: maxOffset,
//            isEnabled: isEnabled
//          )
//        case .layerEffect:
//          view.layerEffect(
//            effect.shader,
//            maxSampleOffset: maxOffset,
//            isEnabled: isEnabled
//          )
//        default:
//          view
//      }
//    } else {
//      view
//    }
//  }
//}
//
//extension View {
//  public func shaderEffects(
//    _ effects: [ShaderEffect],
//    maxOffset: CGSize = .zero,
//    isEnabled: Bool = true
//  ) -> some View {
//    ShaderStackModifier(
//      content: self,
//      effects: effects,
//      maxOffset: maxOffset,
//      isEnabled: isEnabled
//    )
//  }
//}
