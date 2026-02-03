//
//  ViewportSize.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 10/8/2025.
//

import CoreTools
import SwiftUI

/// A Viewport is considered to be a single, self-contained View,
/// not including any native components like Toolbar or Inspector.
///
/// This
public struct EnvironmentViewportSizeModifier: ViewModifier {

  @State private var viewportRect: CGRect?
  @State private var viewportSize: CGSize?

  /// Keeping this internal for now
  let respectsSafeArea: Bool = true

  let mode: DebounceMode
  let showsIndicator: Bool

  public func body(content: Content) -> some View {
    content
      .viewSize(
        capture: .sizeAndSafeInsets,
        //        capture: respectsSafeArea ? .sizeAndSafeInsets : .size,
        mode: mode
      ) { geometry in
        self.viewportRect = geometry.rect
        self.viewportSize = geometry.size
      }
      .viewportSizeIndicator(isEnabled: showsIndicator)

      /// This captures both a size and a rect; a size for ease, and the rect for safe area awareness
      .environment(\.viewportSize, viewportSize)
      .environment(\.viewportRect, viewportRect)
  }
}

extension View {
  /// This now returns a CGRect to allow describing safe area insets,
  /// which wasn't possible with previous CGSize
  ///
  /// If a callback is needed, see ``viewSize(capture:mode:isEnabled:valueOutput:)``
  public func readViewportSize(
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

  fileprivate func viewportSizeIndicator(isEnabled: Bool = true) -> some View {
    self.modifier(ViewportSizeIndicatorModifier(isEnabled: isEnabled))
  }
}
