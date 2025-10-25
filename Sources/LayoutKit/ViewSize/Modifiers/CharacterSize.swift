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
  let character: Character
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

extension View {

  /// Find the size of a single character of a (usually
  /// monospaced) font. Optionally read the container view
  /// size for calculating the Characters-per-dimension etc.
  /// - Parameters:
  ///   - testCharacter: The character to use as source of dimensions
  ///   - sizeDidChange: Callback when the character or view size changes
  /// - Returns: Two optional sizes, the first for the charatcer, the second for the container view
  public func characterSize(
    _ testCharacter: Character = "M",
    mode : DebounceMode = .debounce(0.2),
    _ sizeDidChange: @escaping (CGSize?) -> Void
  ) -> some View {
    self.modifier(
      CharacterSize(
        debounceMode: mode,
        character: testCharacter,
        sizeDidChange: sizeDidChange
      )
    )
  }
}
