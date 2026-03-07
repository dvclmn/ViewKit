//
//  CharacterAndViewSize.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 10/10/2025.
//

import BasePrimitives
import SwiftUI

public struct CharacterAndViewSizeModifier: ViewModifier {
  @State private var characterSize: CGSize?
  @State private var viewSize: CGSize?

  let config: GridFontConfig
//  let font: GridFont
//  let fontSize: CGFloat
  let debounceMode: DebounceMode
  let sizeDidChange: (_ characterSize: CGSize?, _ viewSize: CGSize?) -> Void

  public func body(content: Content) -> some View {
    content
      .modifier(
        CharacterSizeModifier(
          config: config,
//          font: font,
//          fontSize: fontSize,
          debounceMode: debounceMode,
          shouldSetEnv: false
        ) { size in
          characterSize = size
        }
      )
      .viewSize(mode: debounceMode) { size in
        viewSize = size
      }
      .task(id: characterSize) {
        sizeDidChange(characterSize, viewSize)
      }
      .task(id: viewSize) {
        sizeDidChange(characterSize, viewSize)
      }
  }
}
