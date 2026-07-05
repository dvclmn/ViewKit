//
//  ShaderStackModifier.swift
//  ViewKit
//
//  Created by Dave Coleman on 10/2/2026.
//

import SwiftUI

public struct ShaderStackModifier: ViewModifier {

  public static let maximumEffectCount: Int = 4

  let shaders: [ShaderEffect]
  let maxOffset: CGSize
  let isEnabled: Bool

  public func body(content: Content) -> some View {
    let slots = Self.effectSlots(from: shaders)

    content
      .shaderEffect(
        slots[0],
        maxOffset: maxOffset,
        isEnabled: isEnabled,
      )

      .shaderEffect(
        slots[1],
        maxOffset: maxOffset,
        isEnabled: isEnabled,
      )

      .shaderEffect(
        slots[2],
        maxOffset: maxOffset,
        isEnabled: isEnabled,
      )

      .shaderEffect(
        slots[3],
        maxOffset: maxOffset,
        isEnabled: isEnabled,
      )

  }

  static func normalisedEffects(from shaders: [ShaderEffect]) -> [ShaderEffect] {
    Array(
      shaders
        .filter(\.applicationKind.isViewEffect)
        .prefix(Self.maximumEffectCount)
    )
  }

  static func effectSlots(from shaders: [ShaderEffect]) -> [ShaderEffect?] {
    let effects = normalisedEffects(from: shaders)

    return (0..<Self.maximumEffectCount).map { index in
      guard index < effects.count else { return nil }
      return effects[index]
    }
  }
}
extension View {
  public func shaderStack(
    _ shaders: ShaderEffect...,
    maxOffset: CGSize? = nil,
    isEnabled: Bool = true,
  ) -> some View {
    self.modifier(
      ShaderStackModifier(
        shaders: shaders,
        maxOffset: maxOffset ?? .zero,
        isEnabled: isEnabled,
      )
    )
  }
  public func shaderStack(
    _ shaders: [ShaderEffect],
    maxOffset: CGSize? = nil,
    isEnabled: Bool = true,
  ) -> some View {
    self.modifier(
      ShaderStackModifier(
        shaders: shaders,
        maxOffset: maxOffset ?? .zero,
        isEnabled: isEnabled,
      )
    )
  }

  public func shaderStack(
    _ composition: ShaderComposition,
    maxOffset: CGSize? = nil,
    isEnabled: Bool = true,
  ) -> some View {
    shaderStack(
      composition.effects,
      maxOffset: maxOffset,
      isEnabled: isEnabled,
    )
  }
}
