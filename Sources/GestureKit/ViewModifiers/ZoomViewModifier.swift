//
//  ZoomViewModifier.swift
//  LilyPad
//
//  Created by Dave Coleman on 24/6/2025.
//

import CoreTools
import SwiftUI

public typealias ZoomOutput = (MagnificationStream) -> Void

public struct ZoomModifier: ViewModifier {
  //  @Environment(\.modifierKeys) private var modifierKeys
  //  @State private var handler: GestureHandler = .init()
  //  @Binding var interactions: InteractionHandler

  let initialZoom: CGFloat
  let isEnabled: Bool
  let zoomDidChange: ZoomOutput
  //  let geometry: CanvasGeometry?
  public func body(content: Content) -> some View {
    content
      //      .overlay {
      //        PanGestureView {
      //          offset,
      //          phase in
      //          //          guard let geometry else { return }
      //          interactions.updateGesture(
      //            .gesturePan(offset),
      //            phase: phase,
      //            modifiers: modifierKeys
      //          )
      ////          handler.update(.gesturePan(offset), phase: phase, geometry: geometry)
      //          //          handler.update(.pan(state), geometry: geometry)
      //        }
      //      }
      .simultaneousGesture(
        ZoomGesture(initialZoom: initialZoom, isEnabled: true) { stream in
          zoomDidChange(stream)
//          zoomDidChange(zoom, phase)
          //          zoom,
          //          phase in
          //          interactions.updateGesture(
          //            .gestureZoom(zoom),
          //            phase: phase,
          //            modifiers: modifierKeys
          //          )
        },
        //        ZoomGesture(
        //          zoomRange: handler.zoomRange,
        //          isEnabled: true,
        //          didUpdateZoom: { zoom, phase in
        //            guard let geometry, let zoom else { return }
        ////            handler.update(.gestureZoom(zoom), phase: phase, geometry: geometry)
        ////            let adjustment = ZoomOperation.zoom(state.zoom)
        //
        ////            handler.update(.zoom(adjustment), geometry: geometry)
        //          }
        //        ),
        isEnabled: true
      )

  }
}
extension View {
  public func zoomGesture(
    initialZoom: CGFloat,
    isEnabled: Bool = true,
    _ zoomDidChange: @escaping ZoomOutput
  ) -> some View {
    self.modifier(
      ZoomModifier(
        initialZoom: initialZoom,
        isEnabled: isEnabled,
        zoomDidChange: zoomDidChange
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
