//
//  CharacterAndViewSize.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 10/10/2025.
//

import CoreTools
import SwiftUI

public struct CharacterAndViewSizeModifier: ViewModifier {
  @Environment(\.font) private var font

  @State private var characterSize: (any CharacterSize)?
  //  @State private var characterSize: CGSize?
  @State private var viewSize: CGSize?

  let debounceMode: DebounceMode
  let fontSize: CGFloat?
  let sizeDidChange: (_ characterSize: (any CharacterSize)?, _ viewSize: CGSize?) -> Void

  public func body(content: Content) -> some View {
    content
      .characterSize(mode: debounceMode, at: fontSize) { size in
        characterSize = size
      }
      .viewSize(mode: debounceMode) { size in
        viewSize = size
      }
      .task(id: characterSize as? CGSize) {
        sizeDidChange(characterSize, viewSize)
      }
      .task(id: characterSize as? CharacterDimensions) {
        sizeDidChange(characterSize, viewSize)
      }
      .task(id: viewSize) {
        sizeDidChange(characterSize, viewSize)
      }
  }
}
