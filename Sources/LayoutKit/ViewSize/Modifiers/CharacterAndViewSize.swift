//
//  CharacterAndViewSize.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 10/10/2025.
//

import SharedHelpers
import SwiftUI

public struct CharacterAndViewSize: ViewModifier {
  @Environment(\.font) private var font
  
  @State private var characterSize: CGSize?
  @State private var viewSize: CGSize?
  
  let debounceMode: DebounceMode
  let character: Character
  //  let fontStyle: Font
  let sizeDidChange: (CGSize?, CGSize?) -> Void
  
  public func body(content: Content) -> some View {
    content
      .overlay {
        //        VStack(spacing: 0) {
        Text(character.toString)
        //                        .font(font)
          .tracking(0)
          .viewSize(mode: debounceMode) { size in
            characterSize = size
          }
          .hidden()
        //        }
          .allowsHitTesting(false)
      }
      .viewSize(mode: debounceMode) { size in
        viewSize = size
        //        sizeDidChange(size)
      }
      .task(id: characterSize) {
        sizeDidChange(characterSize, viewSize)
      }
      .task(id: viewSize) {
        sizeDidChange(characterSize, viewSize)
      }
  }
}
extension CharacterSize {
  public static func charactersPerAxis(
    _ axis: Axis = .horizontal,
    characterSize: CGSize?,
    containerSize: CGSize?
  ) -> Int? {
    let divisor: CGFloat
    guard let characterSize, let containerSize else { return nil }
    switch axis {
      case .horizontal:
        guard characterSize.width > 0, containerSize.width > 0 else { return nil }
        divisor = characterSize.width
      case .vertical:
        guard characterSize.height > 0, containerSize.height > 0 else { return nil }
        divisor = characterSize.height
    }
    
    let dimension = axis == .horizontal ? containerSize.width : containerSize.height
    return Int(dimension / divisor)
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
  public func characterAndViewSize(
    _ debounceMode: DebounceMode = .debounce(0.2),
    _ testCharacter: Character = "M",
    _ sizeDidChange: @escaping (CGSize?, CGSize?) -> Void
  ) -> some View {
    self.modifier(
      CharacterAndViewSize(
        debounceMode: debounceMode,
        character: testCharacter,
        sizeDidChange: sizeDidChange
      )
    )
  }
}
