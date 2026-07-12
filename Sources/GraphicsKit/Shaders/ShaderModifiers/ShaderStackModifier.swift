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
    let intrinsicMaxOffset = ShaderEffect.maximumSampleOffset(for: shaders, in: .zero)
    let resolvedMaxOffset = CGSize(
      width: max(maxOffset.width, intrinsicMaxOffset.width),
      height: max(maxOffset.height, intrinsicMaxOffset.height),
    )

    content
      .shaderEffect(
        slots[0],
        maxOffset: resolvedMaxOffset,
        isEnabled: isEnabled,
      )

      .shaderEffect(
        slots[1],
        maxOffset: resolvedMaxOffset,
        isEnabled: isEnabled,
      )

      .shaderEffect(
        slots[2],
        maxOffset: resolvedMaxOffset,
        isEnabled: isEnabled,
      )

      .shaderEffect(
        slots[3],
        maxOffset: resolvedMaxOffset,
        isEnabled: isEnabled,
      )
  }
}

extension ShaderStackModifier {
  
  private var slots: [ShaderEffect?] { Self.effectSlots(from: shaders) }
  
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
