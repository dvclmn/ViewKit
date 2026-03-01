//
//  CharacterWidth.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 12/6/2025.
//

import CoreTools
import SwiftUI

typealias CharacterSizeResolver<Size: CharacterSize> = (
  _ testString: TestString,
  _ textBoundingSize: CGSize,
  _ fontSize: CGFloat?
) -> Size?

public struct CharacterSizeModifier<Size: CharacterSize>: ViewModifier {
  @Environment(\.unitSize) private var unitSize

  @State private var characterSize: Size?
  private let testString = TestString.example01

  let debounceMode: DebounceMode
  let fontSize: CGFloat?
  let sizeDidChange: (Size?) -> Void
  let shouldSetEnv: Bool
  let sizeResolver: CharacterSizeResolver<Size>

  public func body(content: Content) -> some View {
    content
      .overlay {
        sizeReaderText
      }
      .environment(\.unitSize, unitSizeResult ?? unitSize)
  }

  @ViewBuilder
  private var sizeReaderText: some View {
    let text = Text(testString.text)
      .fixedSize()
      .allowsTightening(false)
      .viewSize(mode: debounceMode, isEnabled: unitSize == nil) { size in
        handleSizeChange(size)
      }
      .foregroundStyle(.cyan.secondary)
      .hidden()
      .allowsHitTesting(false)

    if let fontSize {
      text.font(.system(size: fontSize, design: .monospaced))
    } else {
      text.monospaced()
    }
  }
}

extension CharacterSizeModifier {

  private func handleSizeChange(_ size: CGSize) {
    let charSize = sizeResolver(testString, size, fontSize)

    if shouldSetEnv {
      self.characterSize = charSize
    }

    sizeDidChange(charSize)
  }

  private var unitSizeResult: CGSize? {
    characterSize?.cgSize
  }
}
