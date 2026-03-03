//
//  ViewExtensions.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 30/10/2025.
//

import CoreTools
import SwiftUI

// MARK: - View size modifiers
extension View {
  /// Previously had default value for `debounceMode`, but this felt
  /// too risky for domains that may be tripped up by immediate vs debounced
  public func viewSize<T: GeometryCapturable>(
    capture: GeometryCapture<T> = .size,
    mode debounceMode: DebounceMode,
    isEnabled: Bool = true,
    valueOutput: @escaping ViewSizeOutput<T>,
  ) -> some View {
    self.modifier(
      ViewSizeModifier(
        capture: capture,
        mode: debounceMode,
        isEnabled: isEnabled,
        valueOutput: valueOutput
      )
    )
  }

  /// This adds a `viewportSize` and `viewportRect`
  /// to the environment. `viewportRect` expresses both
  /// viewport size, and also safe area insets.
  ///
  /// If a callback is needed, see ``viewSize(capture:mode:isEnabled:valueOutput:)``
  public func viewportCapture(
    mode debounceMode: DebounceMode,
    showsIndicator: Bool = false,
  ) -> some View {
    self.modifier(
      EnvironmentViewportSizeModifier(
        mode: debounceMode,
        showsIndicator: showsIndicator
      )
    )
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
    config: GridFontConfig = .automatic,
//    for font: GridFont,
//    size fontSize: CGFloat,
    mode debounceMode: DebounceMode,
    _ sizeDidChange: @escaping (CGSize?, CGSize?) -> Void
  ) -> some View {
    self.modifier(
      CharacterAndViewSizeModifier(
        config: config,
//        font: font,
//        fontSize: fontSize,
        debounceMode: debounceMode,
        sizeDidChange: sizeDidChange
      )
    )
  }

  /// Find the size of a single character of a (usually
  /// monospaced) font. Optionally read the container view
  /// size for calculating the Characters-per-dimension etc.
  /// - Parameters:
  ///   - sizeDidChange: Callback when the character or view size changes
  /// - Returns: Two optional sizes, the first for the charatcer, the second for the container view
  public func characterSize(
    config: GridFontConfig = .automatic,
//    for font: GridFont,
//    size fontSize: CGFloat,
    mode: DebounceMode,
    shouldSetEnv: Bool = false,
    _ sizeDidChange: @escaping (CGSize?) -> Void
  ) -> some View {
    self.modifier(
      CharacterSizeModifier(
        config: config,
//        font: font,
//        fontSize: fontSize,
        debounceMode: mode,
        shouldSetEnv: shouldSetEnv,
        sizeDidChange: sizeDidChange,
      )
    )
  }

  /// For use when an immediate size via callback isn't required.
  /// Just sets the `unitSize` value in the environment.
  public func setCharacterSize(
    config: GridFontConfig = .automatic,
//    for font: GridFont,
//    size fontSize: CGFloat,
    mode: DebounceMode
  ) -> some View {
    self.modifier(
      CharacterSizeModifier(
        config: config,
//        font: font,
//        fontSize: fontSize,
        debounceMode: mode,
        shouldSetEnv: true,
        sizeDidChange: { _ in },
      )
    )
  }
}

//// MARK: - Character Size modifiers
//extension View {
//
//  /// Find the size of a single monospaced character and the containing view size.
//  /// - Parameters:
//  ///   - mode: Debounce mode
//  ///   - fontSize: Explicit size used for measurement text, if provided
//  ///   - sizeDidChange: Callback when the character or view size changes
//  public func characterAndViewSize(
//    mode debounceMode: DebounceMode,
//    at fontSize: CGFloat? = nil,
//    _ sizeDidChange: @escaping (CGSize?, CGSize?) -> Void
//  ) -> some View {
//    self.modifier(
//      CharacterAndViewSizeModifier<CGSize>(
//        debounceMode: debounceMode,
//        fontSize: fontSize,
//        sizeDidChange: sizeDidChange,
//        sizeResolver: resolveCharacterCGSize
//      )
//    )
//  }
//
//  /// Find character size and containing view size, including the explicit font size used.
//  public func characterAndViewSize(
//    mode debounceMode: DebounceMode,
//    at fontSize: CGFloat,
//    _ sizeDidChange: @escaping (CharacterDimensions?, CGSize?) -> Void
//  ) -> some View {
//    self.modifier(
//      CharacterAndViewSizeModifier<CharacterDimensions>(
//        debounceMode: debounceMode,
//        fontSize: fontSize,
//        sizeDidChange: sizeDidChange,
//        sizeResolver: { testString, size, _ in
//          testString.characterDimensions(in: size, at: fontSize)
//        }
//      )
//    )
//  }
//
//  /// Find the size of a single character of a monospaced font.
//  /// - Parameters:
//  ///   - mode: Debounce mode
//  ///   - fontSize: Explicit font size, will inherit from value set in ancestor View if none provided
//  ///   - shouldSetEnv: If true, this modifier will set the `unitSize` EnvironmentValue
//  ///   - sizeDidChange: Callback when the character or view size changes
//  public func characterSize(
//    mode: DebounceMode,
//    at fontSize: CGFloat? = nil,
//    shouldSetEnv: Bool = false,
//    _ sizeDidChange: @escaping (CGSize?) -> Void
//  ) -> some View {
//    self.modifier(
//      CharacterSizeModifier<CGSize>(
//        debounceMode: mode,
//        fontSize: fontSize,
//        sizeDidChange: sizeDidChange,
//        shouldSetEnv: shouldSetEnv,
//        sizeResolver: resolveCharacterCGSize
//      )
//    )
//  }
//
//  /// Find the size of a single character plus the explicit font size used for the measurement.
//  public func characterSize(
//    mode: DebounceMode,
//    at fontSize: CGFloat,
//    shouldSetEnv: Bool = false,
//    _ sizeDidChange: @escaping (CharacterDimensions?) -> Void
//  ) -> some View {
//    self.modifier(
//      CharacterSizeModifier<CharacterDimensions>(
//        debounceMode: mode,
//        fontSize: fontSize,
//        sizeDidChange: sizeDidChange,
//        shouldSetEnv: shouldSetEnv,
//        sizeResolver: { testString, size, _ in
//          testString.characterDimensions(in: size, at: fontSize)
//        }
//      )
//    )
//  }
//
//  @available(
//    *,
//    deprecated,
//    message: "Prefer typed overloads returning CGSize or CharacterDimensions."
//  )
//  @ViewBuilder
//  public func characterAndViewSize(
//    mode debounceMode: DebounceMode,
//    at fontSize: CGFloat? = nil,
//    _ sizeDidChange: @escaping ((any CharacterSize)?, CGSize?) -> Void
//  ) -> some View {
//    if let fontSize {
//      self.characterAndViewSize(mode: debounceMode, at: fontSize) { (characterSize: CharacterDimensions?, viewSize: CGSize?) in
//        sizeDidChange(characterSize, viewSize)
//      }
//    } else {
//      self.characterAndViewSize(mode: debounceMode, at: nil) { (characterSize: CGSize?, viewSize: CGSize?) in
//        sizeDidChange(characterSize, viewSize)
//      }
//    }
//  }
//
//  @available(
//    *,
//    deprecated,
//    message: "Prefer typed overloads returning CGSize or CharacterDimensions."
//  )
//  @ViewBuilder
//  public func characterSize(
//    mode: DebounceMode,
//    at fontSize: CGFloat? = nil,
//    shouldSetEnv: Bool = false,
//    _ sizeDidChange: @escaping ((any CharacterSize)?) -> Void
//  ) -> some View {
//    if let fontSize {
//      self.characterSize(mode: mode, at: fontSize, shouldSetEnv: shouldSetEnv) { (size: CharacterDimensions?) in
//        sizeDidChange(size)
//      }
//    } else {
//      self.characterSize(mode: mode, at: nil, shouldSetEnv: shouldSetEnv) { (size: CGSize?) in
//        sizeDidChange(size)
//      }
//    }
//  }
//
//  /// For use when an immediate size via callback isn't required.
//  /// Just sets the `unitSize` value in the environment.
//  public func setCharacterSize(
//    mode: DebounceMode,
//    at fontSize: CGFloat? = nil
//  ) -> some View {
//    self.modifier(
//      CharacterSizeModifier<CGSize>(
//        debounceMode: mode,
//        fontSize: fontSize,
//        sizeDidChange: { _ in },
//        shouldSetEnv: true,
//        sizeResolver: resolveCharacterCGSize
//      )
//    )
//  }
//
//  /// For use when an immediate size via callback isn't required.
//  /// Just sets the `unitSize` value in the environment.
//  public func setCharacterDimensions(
//    mode: DebounceMode,
//    at fontSize: CGFloat
//  ) -> some View {
//    self.modifier(
//      CharacterSizeModifier<CGSize>(
//        debounceMode: mode,
//        fontSize: fontSize,
//        sizeDidChange: { _ in },
//        shouldSetEnv: true,
//        sizeResolver: resolveCharacterCGSize
//      )
//    )
//  }
//}
//
//private func resolveCharacterCGSize(
//  testString: TestString,
//  textBoundingSize: CGSize,
//  fontSize _: CGFloat?
//) -> CGSize? {
//  testString.characterSize(in: textBoundingSize)
//}
