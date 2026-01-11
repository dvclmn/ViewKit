//
//  PanZoomModifier.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 9/1/2026.
//

import CoreTools
import SwiftUI

public struct PanZoomModifier: ViewModifier {
  @State private var handler: GestureHandler = .init()

  let geometry: CanvasGeometry?
  public func body(content: Content) -> some View {
    content
      .overlay {
        PanGestureView { offset, phase in
          guard let geometry else { return }
          handler.update(.gesturePan(offset), phase: phase, geometry: geometry)
          //          handler.update(.pan(state), geometry: geometry)
        }
      }
      .simultaneousGesture(
        ZoomGesture(
          zoomRange: handler.zoomRange,
          isEnabled: true,
          didUpdateZoom: { zoom, phase in
            guard let geometry, let zoom else { return }
            handler.update(.gestureZoom(zoom), phase: phase, geometry: geometry)
//            let adjustment = ZoomOperation.zoom(state.zoom)
            
//            handler.update(.zoom(adjustment), geometry: geometry)
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
