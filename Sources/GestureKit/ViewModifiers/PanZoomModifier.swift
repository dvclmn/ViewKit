//
//  PanZoomModifier.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 9/1/2026.
//

import SwiftUI

public struct PanZoomModifier: ViewModifier {
  @State private var handler: GestureHandler = .init()

  let geometry: CanvasGeometry?
  public func body(content: Content) -> some View {
    content
      .overlay {
        PanGestureView { state in
          guard let geometry else { return }
          handler.update(.pan(state), geometry: geometry)
        }
      }
      .simultaneousGesture(
        ZoomGesture(
          zoomRange: handler.zoomRange,
          isEnabled: true,
          didUpdateZoom: { state in
            guard let geometry else { return }
            let adjustment = ZoomOperation.zoom(state.zoom)
            handler.update(.zoom(adjustment), geometry: geometry)
          }
        ),
        isEnabled: true
      )

  }
}
extension View {
  public func panAndZoom(geometry: CanvasGeometry?) -> some View {
    self.modifier(PanZoomModifier(geometry: geometry))
  }
}
