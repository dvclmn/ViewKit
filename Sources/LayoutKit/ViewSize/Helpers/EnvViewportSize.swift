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
public struct EnvironmentViewportSizeModifier: ViewModifier {

  @State private var viewportRect: CGRect?

  let mode: DebounceMode
  let showsIndicator: Bool

  public func body(content: Content) -> some View {
    content
      .viewSize(capture: .globalRect, mode: mode) {
        self.viewportRect = $0
      }

      .modifier(ViewportSizeIndicatorModifier(isEnabled: showsIndicator))
      .environment(\.viewportRect, viewportRect)
  }
}
