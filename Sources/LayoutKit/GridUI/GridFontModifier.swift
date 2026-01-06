//
//  GridFontModifier.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 31/10/2025.
//

import SharedHelpers
import SwiftUI
import GridKit

public struct GridFontModifier: ViewModifier {

  let fontStyle: GridFont
  let fontSize: CGFloat

  public func body(content: Content) -> some View {
    content
      .font(gridFont)
//      .monospaced()
      /// Prevents any compression of the spacing between characters
      .allowsTightening(false)
  }
}
extension GridFontModifier {
  private var gridFont: Font {
    return switch fontStyle {
      case .sfMono:
        .system(
          size: fontSize,
          design: .monospaced
        )
      default:
        .custom(fontStyle.rawValue, fixedSize: fontSize)
    }
  }
}
extension View {
  public func gridFont(_ style: GridFont, size: CGFloat = 20) -> some View {
    self.modifier(
      GridFontModifier(
        fontStyle: style,
        fontSize: size
      )
    )
  }
}
