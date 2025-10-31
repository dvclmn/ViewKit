//
//  CharacterWidth.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 12/6/2025.
//

import SharedHelpers
import SwiftUI

public struct CharacterSizeModifier: ViewModifier {
  @Environment(\.unitSize) private var unitSize

  @State private var characterSize: CGSize?

  private let testString = TestString.boxParts

  let debounceMode: DebounceMode
  let sizeDidChange: (CGSize?) -> Void
  let shouldSetEnv: Bool

  public func body(content: Content) -> some View {
    content
      .overlay {
        Text(testString.text)
          .fixedSize()
          .monospaced()
          .allowsTightening(false)
          .viewSize(mode: debounceMode) { size in
            
            /// This derives a single glyph size from the larger
            /// test string being used. The aim being to obtain a more
            /// accurate size, by averaging out any glyph differences
            let charSize = testString.characterSize(size)
            
            /// This value can be used either via the callback,
            /// or by directly updating the `unitSize` env value
            if shouldSetEnv {
              /// This updates the env value
              self.characterSize = charSize
              
            } else {
              
              /// This sends the size to the consumer via callback
              sizeDidChange(charSize)
            }
          }
          .foregroundStyle(.cyan.secondary)
          //          .hidden()
          .allowsHitTesting(false)
          .environment(\.unitSize, shouldSetEnv ? characterSize : unitSize)
      }

  }
}
