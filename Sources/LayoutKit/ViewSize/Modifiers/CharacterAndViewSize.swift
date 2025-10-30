//
//  CharacterAndViewSize.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 10/10/2025.
//

import SharedHelpers
import SwiftUI

public struct CharacterAndViewSize: ViewModifier {
  @Environment(\.font) private var font

  @State private var characterSize: CGSize?
  @State private var viewSize: CGSize?

  let debounceMode: DebounceMode
  let character: Character = "M"
  let sizeDidChange: (CGSize?, CGSize?) -> Void

  public func body(content: Content) -> some View {
    content
      .overlay {
        Text(character.toString)
          .tracking(0)
          .viewSize(mode: debounceMode) { size in
            characterSize = size
          }
          .hidden()
          .allowsHitTesting(false)
      }
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
