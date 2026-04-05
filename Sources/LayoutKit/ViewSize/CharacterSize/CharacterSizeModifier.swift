//
//  CharacterWidth.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 12/6/2025.
//

import BasePrimitives
import BaseTools
import SwiftUI

public struct CharacterSizeModifier: ViewModifier {
  @Environment(\.unitSize) private var unitSize
  @Environment(\.self) private var envSelf
  @State private var characterSize: CGSize?
  private let testString = TestString.example01

  let config: GridFontConfig

  let debounceMode: DebounceMode
  let shouldSetEnv: Bool
  let sizeDidChange: (CGSize?) -> Void

  public func body(content: Content) -> some View {
    content
      .overlay {

        Text(testString.text)
          .gridFont(config: config)
          .monospaced()
          .fixedSize()

          .viewSize(mode: debounceMode, isEnabled: unitSize == nil) { size in

            /// This derives a single glyph size from the multiple-character test string.
            /// The goal of sampling more than a single character is to hopefully obtain
            /// a more accurate reading, by averaging out the results.
            let charSize = testString.singleCharacterSize(in: size)

            /// This value can be used either via the `sizeDidChange` callback,
            /// or by directly updating the `unitSize` env value
            if shouldSetEnv {
              /// This updates the env value
              self.characterSize = charSize
            }

            /// This sends the size to the consumer via callback
            sizeDidChange(charSize)
          }
          .foregroundStyle(.cyan.secondary)
          .hidden()
          .allowsHitTesting(false)
      }
      .environment(\.unitSize, characterSize ?? unitSize)
  }
}
