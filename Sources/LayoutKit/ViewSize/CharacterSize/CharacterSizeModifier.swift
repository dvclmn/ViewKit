//
//  CharacterWidth.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 12/6/2025.
//

import CoreTools
import SwiftUI

public struct CharacterSizeModifier: ViewModifier {
  @Environment(\.unitSize) private var unitSize
  @State private var characterSize: CGSize?
  private let testString = TestString.example01

  let debounceMode: DebounceMode
  let fontSize: CGFloat?
  let sizeDidChange: (CGSize?) -> Void
  let shouldSetEnv: Bool

  public func body(content: Content) -> some View {
    content
      .overlay {
        Text(testString.text)
          .monospaced()
          .fixedSize()
          .allowsTightening(false)

          /// This was a quick test
          //          .onAppear {
          //            self.characterSize = CGSize(100, 200)
          //          }
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
