//
//  CharacterWidth.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 12/6/2025.
//

import SwiftUI

public struct CharacterSize: ViewModifier {
  @Environment(\.font) private var font

  let character: Character
  //  let fontStyle: Font
  let sizeDidChange: (CGSize) -> Void
  public func body(content: Content) -> some View {
    content
      .overlay {
        VStack {
          Text(character.toString)
            //            .font(font)
            .viewSize(mode: .debounce(0.2)) { size in
              sizeDidChange(size)
            }
            .hidden()
        }
        .allowsHitTesting(false)
      }
  }
}
extension View {
  public func characterSize(
    _ testCharacter: Character = "0",
    _ sizeDidChange: @escaping (CGSize) -> Void
  ) -> some View {
    self.modifier(
      CharacterSize(
        character: testCharacter,
        sizeDidChange: sizeDidChange
      )
    )
  }
}
