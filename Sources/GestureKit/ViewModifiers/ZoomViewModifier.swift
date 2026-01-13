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
        //        didUpdateZoom(newZoom, .changed)
      }
      .onEnded { value in
        initialZoom = nil
        zoom.phase = .ended
        //        zoom = ZoomStream(newZoom, phase: .changed)
        //        didUpdateZoom(.zero, .ended)
      }
  }
}
extension View {
  public func zoomGesture(
    zoom: Binding<ZoomState>,
//    initialZoom: CGFloat,
    isEnabled: Bool = true,
//    _ zoomDidChange: @escaping ZoomOutput
  ) -> some View {
    self.modifier(
      ZoomModifier(
        zoom: zoom,
//        initialZoom: initialZoom,
        isEnabled: isEnabled,
//        zoomDidChange: zoomDidChange
      )
    )
  }
  //  public func panAndZoom(interactions: Binding<InteractionHandler>) -> some View {
  //    self.modifier(PanZoomModifier(interactions: interactions))
  //  }
}

//public struct ZoomViewModifier: ViewModifier {
//
//  @GestureState private var magnification: CGFloat = 1
//
//  @State private var initialZoom: CGFloat?
//
//  @Binding var zoom: CGFloat
//
//  let zoomRange: ClosedRange<CGFloat>
//  let isEnabled: Bool
//  let didUpdateZoom: (ZoomState) -> Void
//
//  public func body(content: Content) -> some View {
//    content
//      .simultaneousGesture(zoomGesture(), isEnabled: isEnabled)
//  }
//}
//
//extension ZoomViewModifier {
//
//  func zoomGesture() -> some Gesture {
//    MagnifyGesture()
//      .updating($magnification) { value, state, _ in
//        state = value.magnification
//      }
//      .onChanged { value in
//
//        if initialZoom == nil {
//          initialZoom = zoom
//        }
//        guard let initialZoom else { return }
//
//        let newZoom = (initialZoom) * value.magnification
//        let clampedZoom = newZoom.clamped(to: zoomRange)
//
//        zoom = clampedZoom
//        didUpdateZoom(.active(magnification: clampedZoom))
//      }
//      .onEnded { _ in
//        initialZoom = nil
//        didUpdateZoom(.ended)
//      }
//  }
//}
//
//extension View {
//  public func onZoomGesture(
//    zoom: Binding<CGFloat>,
//    zoomRange: ClosedRange<CGFloat>,
//    isEnabled: Bool = true,
//    didUpdateZoom: @escaping (ZoomState) -> Void = { _ in }
//  ) -> some View {
//    self.modifier(
//      ZoomViewModifier(
//        zoom: zoom,
//        zoomRange: zoomRange,
//        isEnabled: isEnabled,
//        didUpdateZoom: didUpdateZoom
//      )
//    )
//  }
//}
