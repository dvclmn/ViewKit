//
//  Shader+ViewExts.swift
//  ViewKit
//
//  Created by Dave Coleman on 5/7/2026.
//

import SwiftUI

// MARK: - Shader Effect
extension View {
  
  public func shaderEffect(
    _ effect: ShaderEffect?,
    isEnabled: Bool = true,
  ) -> some View {
    self.modifier(
      ShaderModifier(
        effect: effect,
        maxOffset: .zero,
        isEnabled: isEnabled,
      )
    )
  }

  public func shaderEffect(
    _ effect: ShaderEffect?,
    maxOffset: CGSize,
    isEnabled: Bool = true,
  ) -> some View {
    self.modifier(
      ShaderModifier(
        effect: effect,
        maxOffset: maxOffset,
        isEnabled: isEnabled,
      )
    )
  }
}

// MARK: - Shader Stack
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
