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
  @Environment(\.gridFontSize) private var gridFontSize
  @Environment(\.self) private var envSelf
  @Environment(\.isASCIIMode) private var isASCIIMode

  let config: GridFontConfig

  func body(content: Content) -> some View {
    content
      .font(config.descriptor(in: envSelf)?.font)
    
      /// Prevents any compression of the spacing between characters
      .allowsTightening(false)
  }
}

extension View {
  public func gridFont(config: GridFontConfig) -> some View {
    self.modifier(
      GridFontModifier(config: config)
    )
  }

  /// This sets the font for this View. It doesn't set/change any Environment value
  public func gridFont(
    for domain: GridFontDomain = .automatic,
    size: CGFloat? = nil
  ) -> some View {
    self.modifier(
      GridFontModifier(
        config: .domain(domain, size: size)
        //        descriptor: GridFontConfig.domain(domain)
      )
    )
  }

  public func gridFont(_ style: GridFont, size: CGFloat) -> some View {
    self.modifier(
      GridFontModifier(config: .custom(style, size: size))
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
