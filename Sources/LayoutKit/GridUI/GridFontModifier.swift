//
//  GridFontModifier.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 31/10/2025.
//

import CoreTools
import SwiftUI

@AssociatedValues
enum GridFontSize {
  case canvas(CGFloat)
  case asciiUI(CGFloat)

  var size: CGFloat? {
    switch self {
      case .canvas(let fontSize): fontSize
      case .asciiUI(let fontSize): fontSize
    }
  }
}

/// Provides a convenient way to set a Grid font. This doesn't handle any
/// font/glyph geometry etc, just setting the font and font size visually.
struct GridFontModifier: ViewModifier {
  @Environment(\.gridFont) private var gridFont
  @Environment(\.asciiModeFontSize) private var asciiModeFontSize

  let fontStyle: GridFont?
  let fontSize: GridFontSize

  init(
    fontStyle: GridFont?,
    fontSize: GridFontSize
  ) {
    self.fontStyle = fontStyle
    self.fontSize = fontSize
  }

  func body(content: Content) -> some View {
    content
      .font(finalGridFont)
      /// Prevents any compression of the spacing between characters
      .allowsTightening(false)
      .environment(\.gridFont, fontStyle)
      .environment(\.asciiModeFontSize, fontSize.asciiUIValue ?? asciiModeFontSize)
  }
}

extension GridFontModifier {

  private var finalGridFont: Font? {
    guard let fontSize = fontSize.size else { return nil }
    guard let font = fontStyle ?? gridFont else { return nil }
    return switch font {
      case .sfMono:
        .system(
          size: fontSize,
          design: .monospaced
        )
      default:
        .custom(font.rawValue, fixedSize: fontSize)
    }
  }
}
extension View {
  public func gridFont(
    _ style: GridFont,
    size: CGFloat = 20
  ) -> some View {
    self.modifier(
      GridFontModifier(
        fontStyle: style,
        fontSize: .canvas(size)
      )
    )
  }

  /// This does not set a `GridFont` in the Environment.
  /// Use ``gridFont(_:size:)`` first if there no grid font present yet.
  public func asciiUIFont(size: CGFloat = 20) -> some View {
    self.modifier(
      GridFontModifier(
        fontStyle: nil,
        fontSize: .asciiUI(size)
      )
    )
  }
}
