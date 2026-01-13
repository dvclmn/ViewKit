//
//  ZoomViewModifier.swift
//  LilyPad
//
//  Created by Dave Coleman on 24/6/2025.
//

import CoreTools
import SwiftUI

public typealias ZoomOutput = (CGFloat, InteractionPhase) -> Void

public struct ZoomModifier: ViewModifier {
  @Environment(\.canvasZoomRange) private var zoomRange
  @GestureState private var magnification: CGFloat = 1
  @State private var initialZoom: CGFloat?

  @Binding var zoom: ZoomState
  let isEnabled: Bool

  public func body(content: Content) -> some View {
    content
      .simultaneousGesture(zoomGesture, isEnabled: isEnabled)
  }
}
extension ZoomModifier {
  private var zoomGesture: some Gesture {
    MagnifyGesture()
      .updating($magnification) { value, state, _ in
        state = value.magnification
      }
      .onChanged { value in

        if initialZoom == nil {
          initialZoom = zoom.zoom(clampedTo: zoomRange ?? 0...10)
        }
        guard let initialZoom else { return }

        let newZoom = initialZoom * value.magnification
        zoom = ZoomState(newZoom, phase: .changed)
      }
      .onEnded { value in
        initialZoom = nil
        zoom.phase = .ended
      }
  }
}
extension View {
  public func zoomGesture(
    zoom: Binding<ZoomState>,
    isEnabled: Bool = true,
  ) -> some View {
    self.modifier(
      ZoomModifier(
        zoom: zoom,
        isEnabled: isEnabled,
      )
    )
  }
}
