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
  @Environment(\.self) private var envSelf
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
  private var fontResult: Font? {
    config.descriptor(in: envSelf)?.font ?? fallbackFont
  }
}

extension View {
  public func gridFont(
    config: GridFontConfig,
    fallback: Font? = nil
  ) -> some View {
    self.modifier(
      GridFontModifier(config: config, fallbackFont: fallback)
    )
  }

  /// This sets the font for this View. It doesn't set/change any Environment value
  public func gridFont(
    for domain: GridFontDomain = .automatic,
    size: CGFloat? = nil,
    fallback: Font? = nil
  ) -> some View {
    self.modifier(
      GridFontModifier(
        config: .domain(domain, size: size),
        fallbackFont: fallback
          //        descriptor: GridFontConfig.domain(domain)
      )
    )
  }

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

/// Provides a convenient way to set a Grid font. This doesn't handle any
/// font/glyph geometry etc, just setting the font and font size visually.
//struct GridFontModifier: ViewModifier {
//  @Environment(\.gridFont) private var gridFont
//  @Environment(\.asciiModeFontSize) private var asciiModeFontSize
//
//  let fontStyle: GridFont?
//  let fontSize: CGFloat
//
//  func body(content: Content) -> some View {
//    content
//      .font(finalGridFont)
//      /// Prevents any compression of the spacing between characters
//      .allowsTightening(false)
//      .environment(\.gridFont, fontStyle)
//    //      .environment(\.asciiModeFontSize, fontSize.asciiUIValue ?? asciiModeFontSize)
//  }
//}
//

//extension View {
//  public func gridFont(
//    _ style: GridFont,
//    size: CGFloat = 20
//  ) -> some View {
//    self.modifier(
//      GridFontModifier(
//        fontStyle: style,
//        fontSize: size
//        //        fontSize: .canvas(size)
//      )
//    )
//  }
//
//  public func gridFontSize(
//    size: CGFloat
//  ) -> some View {
//    self.modifier(
//      GridFontModifier(
//        fontStyle: nil,
//        fontSize: size
//        //        fontSize: .canvas(size)
//      )
//    )
//  }
//}

//  /// This does not set a `GridFont` in the Environment.
//  /// Use ``gridFont(_:size:)`` first if there no grid font present yet.
//  public func asciiUIFont(size: CGFloat = 20) -> some View {
//    self.modifier(
//      GridFontModifier(
//        fontStyle: nil,
//        fontSize: .asciiUI(size)
//      )
//    )
//  }
//}
