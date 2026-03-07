//
//  ViewExtensions.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 30/10/2025.
//

import BasePrimitives
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
    //    showsIndicator: Bool = false,
  ) -> some View {
    self.modifier(
      EnvironmentViewportSizeModifier(
        mode: debounceMode,
        //        showsIndicator: showsIndicator
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
    mode debounceMode: DebounceMode,
    _ sizeDidChange: @escaping (CGSize?, CGSize?) -> Void
  ) -> some View {
    self.modifier(
      CharacterAndViewSizeModifier(
        config: config,
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
    mode: DebounceMode,
    shouldSetEnv: Bool = false,
    _ sizeDidChange: @escaping (CGSize?) -> Void
  ) -> some View {
    self.modifier(
      CharacterSizeModifier(
        config: config,
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
    mode: DebounceMode
  ) -> some View {
    self.modifier(
      CharacterSizeModifier(
        config: config,
        debounceMode: mode,
        shouldSetEnv: true,
        sizeDidChange: { _ in },
      )
    )
  }
}
