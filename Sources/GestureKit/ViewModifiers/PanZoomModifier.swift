//
//  PanZoomModifier.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 9/1/2026.
//

import SwiftUI

public struct PanZoomModifier: ViewModifier {
  @State private var handler: GestureHandler = .init()

  public func body(content: Content) -> some View {
    content
      .overlay {
        PanGestureView { state in
          handler.update(.pan(state))
        }
      }
      .simultaneousGesture(
        ZoomGesture(
          zoomRange: handler.zoomRange,
          isEnabled: true,
          didUpdateZoom: { state in
            handler.update(.zoom(state))
          }
        ),
        isEnabled: true
      )

  }
}
extension View {
  public func panAndZoom() -> some View {
    self.modifier(ExampleModifier())
  }
}
