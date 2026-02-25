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
  @State private var viewportSize: CGSize?

  /// Keeping this internal for now
  //  let respectsSafeArea: Bool = true

//  let captureArea: CaptureArea
//  let capture: GeometryCapture<Capture>
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
      .modifier(ViewportSizeIndicatorModifier(isEnabled: showsIndicator))
      //      .viewportSizeIndicator(isEnabled: showsIndicator)

      /// This captures both a size and a rect; a size for ease, and the rect for safe area awareness
      .environment(\.viewportSize, viewportSize)
      .environment(\.viewportRect, viewportRect)
  }
}

extension View {

}
