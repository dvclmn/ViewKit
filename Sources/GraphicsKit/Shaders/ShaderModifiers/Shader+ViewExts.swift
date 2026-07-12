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
        maxOffset: effect?.maximumSampleOffset(for: .zero) ?? .zero,
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

  public func shaderEffect(
    _ effect: ShaderEffect?,
    maxOffsetFor size: CGSize,
    isEnabled: Bool = true,
  ) -> some View {
    shaderEffect(
      effect,
      maxOffset: effect?.maximumSampleOffset(for: size) ?? .zero,
      isEnabled: isEnabled,
    )
  }
}

// MARK: - Shader Stack
extension View {
  
  public func shaderStack(
    _ shaders: ShaderEffect...,
    maxOffset: CGSize = .zero,
    isEnabled: Bool = true,
  ) -> some View {
    self.modifier(
      ShaderStackModifier(
        shaders: shaders,
        maxOffset: maxOffset,
        isEnabled: isEnabled,
      )
    )
  }

  public func shaderStack(
    _ shaders: ShaderEffect...,
    maxOffsetFor size: CGSize,
    isEnabled: Bool = true,
  ) -> some View {
    shaderStack(
      shaders,
      maxOffset: ShaderEffect.maximumSampleOffset(for: shaders, in: size),
      isEnabled: isEnabled,
    )
  }

  public func shaderStack(
    _ shaders: [ShaderEffect],
    maxOffset: CGSize,
    isEnabled: Bool = true,
  ) -> some View {
    self.modifier(
      ShaderStackModifier(
        shaders: shaders,
        maxOffset: maxOffset,
        isEnabled: isEnabled,
      )
    )
  }

  public func shaderStack(
    _ shaders: [ShaderEffect],
    maxOffsetFor size: CGSize,
    isEnabled: Bool = true,
  ) -> some View {
    shaderStack(
      shaders,
      maxOffset: ShaderEffect.maximumSampleOffset(for: shaders, in: size),
      isEnabled: isEnabled,
    )
  }

  public func shaderStack(
    _ composition: ShaderComposition,
    maxOffset: CGSize = .zero,
    isEnabled: Bool = true,
  ) -> some View {
    shaderStack(
      composition.effects,
      maxOffset: maxOffset,
      isEnabled: isEnabled,
    )
  }

  public func shaderStack(
    _ composition: ShaderComposition,
    maxOffsetFor size: CGSize,
    isEnabled: Bool = true,
  ) -> some View {
    shaderStack(
      composition.effects,
      maxOffsetFor: size,
      isEnabled: isEnabled,
    )
  }
}
