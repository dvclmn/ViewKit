//
//  ViewportSize.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 10/8/2025.
//

import BasePrimitives
import SwiftUI

/// A Viewport is considered to be a single, self-contained View,
/// not including any native components like Toolbar or Inspector.
public struct EnvironmentViewportSizeModifier: ViewModifier {
  @Environment(\.isDebugMode) private var isDebugMode
  @State private var viewportRect: CGRect?

  let mode: DebounceMode

  public func body(content: Content) -> some View {
    content
      .viewSize(capture: .safeAreaRect, mode: mode) {
        self.viewportRect = $0.rect
      }

//      .modifier(ViewportSizeIndicatorModifier(isEnabled: isDebugMode))
      .environment(\.viewportRect, viewportRect)
  }
}
