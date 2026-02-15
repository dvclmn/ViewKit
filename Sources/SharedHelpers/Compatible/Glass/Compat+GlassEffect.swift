//
//  Compat+GlassEffect.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 20/9/2025.
//

import SwiftUI

extension View {
  @ViewBuilder
  public func glassEffectCompatible<S: Shape>(
    glass: GlassTypeCompatible = .regular,
    in shape: S,
  ) -> some View {
    if #available(macOS 26, iOS 26, *) {
      glassEffect(glass.glassType, in: shape)
    } else {
      self
    }
  }
}

public enum GlassTypeCompatible {
  case regular
  case clear
  case identity // No glass effect at all

  @available(macOS 26, iOS 26, *)
  public var glassType: Glass {
    switch self {
      case .regular: .regular
      case .clear: .clear
      case .identity: .identity
    }
  }
}
