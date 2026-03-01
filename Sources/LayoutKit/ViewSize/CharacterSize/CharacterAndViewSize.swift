//
//  CharacterAndViewSize.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 10/10/2025.
//

import CoreTools
import SwiftUI

public struct CharacterAndViewSizeModifier<Size: CharacterSize>: ViewModifier {
  @State private var characterSize: Size?
  @State private var viewSize: CGSize?

  let debounceMode: DebounceMode
  let fontSize: CGFloat?
  let sizeDidChange: (_ characterSize: Size?, _ viewSize: CGSize?) -> Void
  let sizeResolver: CharacterSizeResolver<Size>

  public func body(content: Content) -> some View {
    content
      .modifier(
        CharacterSizeModifier<Size>(
          debounceMode: debounceMode,
          fontSize: fontSize,
          sizeDidChange: { size in
            characterSize = size
          },
          shouldSetEnv: false,
          sizeResolver: sizeResolver
        )
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
