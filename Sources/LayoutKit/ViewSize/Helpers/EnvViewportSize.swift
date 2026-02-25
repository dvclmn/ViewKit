//
//  ViewportSize.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 10/8/2025.
//

import CoreTools
import SwiftUI

//public enum CaptureArea {
//  case viewport
//  case viewportAndSafeArea
//}

/// A Viewport is considered to be a single, self-contained View,
/// not including any native components like Toolbar or Inspector.
public struct EnvironmentViewportSizeAndSafeAreaModifier: ViewModifier {
  /// Uses a rect to express the size of the safe area (using the origin)
  @State private var viewportRect: CGRect?

  let mode: DebounceMode
  let showsIndicator: Bool

  public func body(content: Content) -> some View {
    content
      .modifier(
        ViewSizeModifier<SizeAndSafeInsets>(
          capture: .sizeAndSafeInsets,
          mode: mode,
          isEnabled: true
        ) { geometry in
          viewportRect = geometry.rect
        }

      )
      //      .viewSize(
      //        capture: .sizeAndSafeInsets,
      //        mode: mode
      //      ) { geometry in
      //        self.viewportRect = geometry.rect
      //      }
      .modifier(ViewportSizeIndicatorModifier(isEnabled: showsIndicator))
      .environment(\.viewportRect, viewportRect)
  }
}
public struct EnvironmentViewportSizeModifier: ViewModifier {

  @State private var viewportSize: CGSize?

  let mode: DebounceMode
  let showsIndicator: Bool

  public func body(content: Content) -> some View {
    content
      .modifier(
        ViewSizeModifier<CGSize>(
          capture: .size,
          mode: mode,
          isEnabled: true
          ) { size in
            viewportSize = size
          }
        )
      )
      //      .viewSize(
      //        capture: .size,
      //        mode: mode
      //      ) { geometry in
      //        self.viewportSize = geometry.size
      //      }
      .modifier(ViewportSizeIndicatorModifier(isEnabled: showsIndicator))
      //      .viewportSizeIndicator(isEnabled: showsIndicator)

      /// This captures both a size and a rect; a size for ease, and the rect for safe area awareness
      .environment(\.viewportSize, viewportSize)
      .environment(\.viewportRect, viewportRect)
  }
}

extension View {

}
