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
    _ glass: GlassTypeCompatible? = .regular,
    in shape: S,
  ) -> some View {
    if #available(macOS 26, iOS 26, *), let glass {
      glassEffect(glass.glassType, in: shape)
    } else {
      self
    }
  }
}

public enum GlassTypeCompatible: Sendable {
  case regular(tint: Color? = nil)
  case clear
  case identity  // No glass effect at all
  public static let regular: Self = .regular()

  @available(macOS 26, iOS 26, *)
  public var glassType: Glass {
    switch self {
      case .regular(let tint):
        guard let tint else { return .regular }
        return .regular.tint(tint)
      case .clear:
        return .clear
      case .identity:
        return .identity
    }
  }
}
