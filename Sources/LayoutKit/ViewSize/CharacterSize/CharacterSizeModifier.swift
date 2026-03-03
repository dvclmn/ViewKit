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
  @Environment(\.self) private var envSelf
  @State private var characterSize: CGSize?
  private let testString = TestString.example01

//  let font: GridFont
//  let fontSize: CGFloat
  
  let config: GridFontConfig
  
  let debounceMode: DebounceMode
  let shouldSetEnv: Bool
  let sizeDidChange: (CGSize?) -> Void

  public func body(content: Content) -> some View {
    content
      .overlay {
        
       

          .monospaced()
          .fixedSize()
          .allowsTightening(false)

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

extension CharacterSizeModifier {
  @ViewBuilder
  private func TextMeasurementView() -> some View {
    
    if let descriptor = config.descriptor(in: envSelf) {
      Text(testString.text)
        .font(descriptor)
    } else {
      Text(testString.text)
    }
//    switch config {
//      case .domain(let domain):
//        
//      case .custom(let font, let size):
//      case .passthrough:
//        
//    }
  }
}

//typealias CharacterSizeResolver<Size: CharacterSize> = (
//  _ testString: TestString,
//  _ textBoundingSize: CGSize,
//  _ fontSize: CGFloat?
//) -> Size?

//public struct CharacterSizeModifier: ViewModifier {
////public struct CharacterSizeModifier<Size: CharacterSize>: ViewModifier {
//  @Environment(\.unitSize) private var unitSize
//
//  @State private var characterSize: CGSize?
////  @State private var characterSize: Size?
//  private let testString = TestString.example01
//
//  let debounceMode: DebounceMode
//  let fontSize: CGFloat?
//  let sizeDidChange: (CGSize?) -> Void
////  let sizeDidChange: (Size?) -> Void
//  let shouldSetEnv: Bool
////  let sizeResolver: CharacterSizeResolver<Size>
//
//  public func body(content: Content) -> some View {
//    content
//      .overlay {
//        sizeReaderText
//      }
//      .environment(\.unitSize, unitSizeResult ?? unitSize)
//  }
//
//  @ViewBuilder
//  private var sizeReaderText: some View {
//    let text = Text(testString.text)
//      .fixedSize()
//      .allowsTightening(false)
//      .viewSize(mode: debounceMode, isEnabled: unitSize == nil) { size in
//        handleSizeChange(size)
//      }
//      .foregroundStyle(.cyan.secondary)
//      .hidden()
//      .allowsHitTesting(false)
//
//    if let fontSize {
//      text.font(.system(size: fontSize, design: .monospaced))
//    } else {
//      text.monospaced()
//    }
//  }
//}
//
//extension CharacterSizeModifier {
//
//  private func handleSizeChange(_ size: CGSize) {
//    let charSize = sizeResolver(testString, size, fontSize)
//
//    if shouldSetEnv {
//      self.characterSize = charSize
//    }
//
//    sizeDidChange(charSize)
//  }
//
//  private var unitSizeResult: CGSize? {
//    characterSize?.cgSize
//  }
//}
