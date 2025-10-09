//
//  CharacterWidth.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 12/6/2025.
//

import SwiftUI

public struct CharacterSize: ViewModifier {
  @Environment(\.font) private var font

  @State private var characterSize: CGSize?
  @State private var viewSize: CGSize?

  let character: Character
  //  let fontStyle: Font
  let sizeDidChange: (CGSize, CGSize) -> Void
  public func body(content: Content) -> some View {
    content
      .overlay {
        VStack {
          Text(character.toString)
            //            .font(font)
            .viewSize(mode: .debounce(0.2)) { size in
              characterSize = size
            }
            .hidden()
        }
        .allowsHitTesting(false)
      }
      .viewSize(mode: .debounce(0.2)) { size in
        viewSize = size
        //        sizeDidChange(size)
      }
      .task(id: characterSize) {
        sizeDidChange(characterSize ?? .zero, viewSize ?? .zero)
      }
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
    _ testCharacter: Character = "0",
    _ sizeDidChange: @escaping (CGSize?, CGSize?) -> Void
  ) -> some View {
    self.modifier(
      CharacterSize(
        character: testCharacter,
        sizeDidChange: sizeDidChange
      )
    )
  }
}
