//
//  CharacterWidth.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 12/6/2025.
//

import SharedHelpers
import SwiftUI

public struct CharacterSize: ViewModifier {
  @Environment(\.font) private var font

  @State private var characterSize: CGSize?
  @State private var viewSize: CGSize?

  let debounceMode: DebounceMode
  let character: Character = "M"
  let sizeDidChange: (CGSize?) -> Void

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
      .task(id: characterSize) {
        sizeDidChange(characterSize)
      }
//      .task(id: viewSize) {
//        sizeDidChange(characterSize, viewSize)
//      }
  }
}
