//
//  PanZoomModifier.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 9/1/2026.
//

import CoreTools
import SwiftUI

public typealias ZoomOutput = (CGFloat, InteractionPhase) -> Void

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
        ZoomGesture(initialZoom: initialZoom, isEnabled: true) { zoom, phase in
          zoomDidChange(zoom, phase)
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
