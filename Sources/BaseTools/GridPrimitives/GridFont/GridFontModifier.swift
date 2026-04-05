//
//  GridFontModifier.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 31/10/2025.
//

import SwiftUI

struct GridFontModifier: ViewModifier {
  @Environment(\.gridFont) private var gridFont
  @Environment(\.asciiModeFontSize) private var asciiModeFontSize
  @Environment(\.gridCanvasFontSize) private var gridCanvasFontSize
  @Environment(\.self) private var env
  @Environment(\.isASCIIMode) private var isASCIIMode

  let config: GridFontConfig
  let fallbackFont: Font?

  func body(content: Content) -> some View {
    content
      .font(fontResult)

      /// Prevents any compression of the spacing between characters
      .allowsTightening(!hasFontResult)
  }
}
extension GridFontModifier {
  private var hasFontResult: Bool { fontResult != nil }
  private var fontResult: Font? { config.descriptor(in: env)?.font ?? fallbackFont }
}

extension View {
  /// Sets the ``GridFont`` for this View. Doesn't set/change any Environment value
  public func gridFont(
    config: GridFontConfig,
    fallback: Font? = nil
  ) -> some View {
    self.modifier(
      GridFontModifier(config: config, fallbackFont: fallback)
    )
  }

  /// Sets the ``GridFont`` for this View. Doesn't set/change any Environment value
  public func gridFont(
    for domain: GridFontDomain = .automatic,
    size: CGFloat? = nil,
    fallback: Font? = nil
  ) -> some View {
    self.modifier(
      GridFontModifier(
        config: .domain(domain, size: size),
        fallbackFont: fallback
      )
    )
  }

  /// Sets the ``GridFont`` for this View. Doesn't set/change any Environment value
  public func gridFont(
    _ font: GridFont,
    size: CGFloat
  ) -> some View {
    self.modifier(
      GridFontModifier(
        config: .custom(font, size: size),
        fallbackFont: nil
      )
    )
  }
}
