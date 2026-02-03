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
  //  @Environment(\.isDebugMode) private var isDebugMode
  @State private var viewportSize: CGSize?

  let mode: DebounceMode
  let showsIndicator: Bool
  let didUpdateSize: ViewSizeOutput<CGSize>?

  public func body(content: Content) -> some View {
    content
      .viewSize(mode: mode) { size in
        self.viewportSize = size
        didUpdateSize?(size)
      }
      .border(Color.green.opacity(0.3))
      .viewportSizeIndicator(isEnabled: showsIndicator)
      .environment(\.viewportSize, viewportSize)
  }
}

extension View {
  public func readViewportSize(
    mode debounceMode: DebounceMode,
    showsIndicator: Bool = false,
    didUpdateSize: ViewSizeOutput<CGSize>? = nil,
  ) -> some View {
    self.modifier(
      EnvironmentViewportSizeModifier(
        mode: debounceMode,
        showsIndicator: showsIndicator,
        didUpdateSize: didUpdateSize
      )
    )
  }
  fileprivate func viewportSizeIndicator(isEnabled: Bool = true) -> some View {
    self.modifier(ViewportSizeIndicatorModifier(isEnabled: isEnabled))
  }
}
