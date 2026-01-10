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

  @State private var characterSize: CGSize?
  @State private var viewSize: CGSize?

  let debounceMode: DebounceMode
  let sizeDidChange: (CGSize?, CGSize?) -> Void

  public func body(content: Content) -> some View {
    content
      .characterSize(mode: debounceMode) { size in
        characterSize = size
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
