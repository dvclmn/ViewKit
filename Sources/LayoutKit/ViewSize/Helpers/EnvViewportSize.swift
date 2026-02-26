//
//  ViewportSize.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 10/8/2025.
//

import CoreTools
import SwiftUI

enum CaptureArea {
  case viewport
  case viewportAndSafeArea
}

/// A Viewport is considered to be a single, self-contained View,
/// not including any native components like Toolbar or Inspector.
public struct EnvironmentViewportSizeModifier: ViewModifier {

  @State private var viewportRect: CGRect?
//  @State private var viewportSize: CGSize?

  let mode: DebounceMode
  let showsIndicator: Bool

  public func body(content: Content) -> some View {
    content
      /// `sizeAndSafeInsets` is able to return both the size,
      /// as well as the insets
      .viewSize(
        capture: .safeGlobalRect,
        mode: mode
      ) {
        self.viewportRect = $0
      }
      //      .viewSize(
      //        capture: .sizeAndSafeInsets,
      //        mode: mode
      //      ) { geometry in
      //
      //        self.viewportRect = geometry.rect
      //        self.viewportSize = geometry.size
      //      }
      .modifier(ViewportSizeIndicatorModifier(isEnabled: showsIndicator))

      /// This captures both a size and a rect; a size for ease, and the rect for safe area awareness
      //      .environment(\.viewportSize, viewportSize)
      .environment(\.viewportRect, viewportRect)
  }
}

extension View {

}

//if let viewportSize {
//  print(
//    "🔔 Existing Environment value found for `viewportSize`: \(viewportSize). May be worth checking whether it can be used, rather than re-capturing via this modifier."
//  )
//  }
