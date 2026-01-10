//
//  GridSetupModifier.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 1/11/2025.
//

import BasePrimitives
import SwiftUI

/// Aims to produce a full setup with Grid Font,
/// Character measure for unit size, injecting
/// into environment, etc.

public struct GridSetupModifier: ViewModifier {
  let fontStyle: GridFont
  let fontSize: CGFloat

  /// optional convenience if the consumer wants this value,
  /// rather than set straight to env
  let sizeDidChange: (CGSize?) -> Void

  public func body(content: Content) -> some View {
    content
      .characterSize(
        mode: .noDebounce,
        shouldSetEnv: true,
        sizeDidChange
      )
      .gridFont(fontStyle, size: fontSize)

  }
}

extension View {
  public func gridSetup(
    _ fontStyle: GridFont,
    fontSize: CGFloat,
    _ sizeDidChange: @escaping (CGSize?) -> Void = { _ in },
  ) -> some View {
    self.modifier(
      GridSetupModifier(
        fontStyle: fontStyle,
        fontSize: fontSize,
        sizeDidChange: sizeDidChange,
      )
    )
  }
}
