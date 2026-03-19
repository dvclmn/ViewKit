//
//  TapDragModifier.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 14/1/2026.
//

import SwiftUI

public struct PointerDragModifier: ViewModifier {

  //  @State private var store: DragHandler
  @State private var dragState: DragGestureState

  /// Internal rect — the modifier's own source of truth.
  /// Always kept in sync with the external binding (if any).
  @State private var internalPayload: PointerDragPayload?
  //  @State private var internalRect: CGRect?

  /// Guards against syncing external changes during a live gesture.
  @State private var isGesturing: Bool = false

  #warning(
    "Currently unsure whether `externalRect` and `commitRect` come along with the new transition to `PointerDragPayload`"
  )
  /// External state to observe. In Mode A this is read-write (the modifier
  /// writes back via ``commitRect``). In Mode B this is read-only (sync only).
  private let externalPayload: Binding<PointerDragPayload?>?
  //  private let externalRect: Binding<CGRect?>?

  /// When `true`, ``commitRect`` writes to ``externalRect`` (Mode A).
  /// When `false`, the modifier only updates ``internalRect`` (Mode B).

  let coordinateSpace: CoordinateSpace
  let writesBackToBinding: Bool
  //  let behaviour: DragBehavior
  //  let drawsMarqueeRect: Bool
  let minimumDistance: CGFloat
  let didUpdatePayload: DragEventUpdate

  init(
    payload: Binding<PointerDragPayload?>?,
    //    rect: Binding<CGRect?>? = nil,
    writesBackToBinding: Bool = true,
    coordinateSpace: CoordinateSpace,
    behaviour: DragBehavior,
    //    drawsMarqueeRect: Bool,
    minimumDistance: CGFloat,
    didUpdatePayload: @escaping DragEventUpdate = { _, _ in }
  ) {
    self.externalPayload = payload
    self.coordinateSpace = coordinateSpace
    self.writesBackToBinding = writesBackToBinding
    //    self.behaviour = behaviour
    //    self.drawsMarqueeRect = drawsMarqueeRect
    self.minimumDistance = minimumDistance
    self.didUpdatePayload = didUpdatePayload

    //    self._store = State(
    //      initialValue: DragHandler(
    //        externalPayload: payload,
    //        internalPayload: <#T##PointerDragPayload?#>
    //        dragState: DragGestureState(behaviour),
    //        writesBackToBinding: writesBackToBinding,
    //        coordinateSpace: coordinateSpace,
    //        minimumDragDistance: minimumDistance,
    //      )
    //    )
    self._dragState = State(initialValue: DragGestureState(behaviour))
    self._internalPayload = State(initialValue: payload?.wrappedValue)
  }

  public func body(content: Content) -> some View {
    content
      .gesture(dragGesture, isEnabled: isDragEnabled)
      //      .gesture(PointerDrag(store: store), isEnabled: isDragEnabled)
      //      .gesture(dragGesture, isEnabled: isDragEnabled)
      .drawMarqueeRect(rect: internalPayload?.boundingRect?.cgRect, isEnabled: isMarqueeRectEnabled)
      //      .drawMarqueeRect(rect: internalRect, isEnabled: isMarqueeRectEnabled)

      .onChange(of: behaviour) { _, newValue in
        dragState.behaviour = newValue
        dragState.end()
//        commitPayload(nil, external: externalPayload)
      }

      .onChange(of: externalPayload?.wrappedValue) { _, newValue in
        /// External source changed (e.g. reset button, scroll gesture,
        /// programmatic pan). Only adopt when NOT actively gesturing,
        /// to avoid fighting with the live drag.
        guard !isGesturing else { return }
        internalPayload = newValue
      }
      
  }
}

extension PointerDragModifier {
  var behaviour: DragBehavior { dragState.behaviour }
  private var dragGesture: some Gesture {
    DragGesture(
      minimumDistance: minimumDistance,
      coordinateSpace: coordinateSpace
    )
    .onChanged { gestureValue in
      isGesturing = true
      let payload = dragState.update(gestureValue)
      internalPayload = payload
      // Legacy rect support:
//      let rect = payload?.boundingRect // your helper to extract rect, if possible
//      commitRect(rect)
      didUpdatePayload(payload, .changed)
//      didUpdateEvent?(makeDragGestureEvent(from: gestureValue, payload: payload), .changed)
    }
    .onEnded { gestureValue in
      let payload = dragState.update(gestureValue)
      internalPayload = payload
//      commitRect(nil)
      didUpdatePayload(payload, .ended)
//      didUpdateEvent?(makeDragGestureEvent(from: gestureValue, payload: payload), .ended)
      dragState.end()
      isGesturing = false
    }
//    .onChanged { value in
//      let isGestureStart = !isGesturing
//
//      if isGestureStart {
//        isGesturing = true
//
//        /// Anchor once per drag. Marquee uses the gesture start location;
//        /// continuous uses the current internal offset as the baseline.
//        dragState.begin(
//          with: behaviour.isMarquee
//            ? value.startLocation
//            : internalPayload?.size.toCGPoint
//        )
//      }
//
//      let proposed: PointerDragPayload? = dragState.update(value)
//      commitPayload(proposed)
//
//      //      let event = DragGestureEvent(
//      //        behaviour: behaviour,
//      //        proposedRect: proposedRect,
//      //        startLocation: value.startLocation,
//      //        currentLocation: value.location,
//      //        translation: value.translation,
//      //        isGestureStart: isGestureStart
//      //      )
//
//      didUpdateEvent(internalPayload, isGestureStart ? .began : .changed)
//    }
//
//    .onEnded { value in
//      let proposed: PointerDragPayload? = behaviour.isMarquee ? nil : internalPayload
//      //      let proposedRect: CGRect? = behaviour.isMarquee ? nil : internalPayload
//      commitPayload(proposed)
//
//      //      let event = DragGestureEvent(
//      //        behaviour: behaviour,
//      //        proposedRect: proposedRect,
//      //        startLocation: value.startLocation,
//      //        currentLocation: value.location,
//      //        translation: value.translation,
//      //        isGestureStart: false
//      //      )
//      didUpdateEvent(proposed, .ended)
//
//      isGesturing = false
//      dragState.end()
//    }
  }
  //  }

  private var isDragEnabled: Bool { behaviour.isEnabled }
  private var isMarqueeRectEnabled: Bool { behaviour.isMarquee }

  /// Writes the rect to internal state and, in Mode A, back to the binding.
  func commitPayload(
    _ payload: PointerDragPayload?,
    //    external: Binding<PointerDragPayload?>?,
  ) {
    //    internalRect = payload?.boundingRect
    internalPayload = payload

    if writesBackToBinding {
      externalPayload?.wrappedValue = payload
      //      externalPayload?.wrappedValue = payload
      //      externalRect?.wrappedValue = payload?.boundingRect
    }
  }
  //  func commitRect(_ rect: CGRect?) {
  //    internalRect = rect
  //    if writesBackToBinding {
  //      externalRect?.wrappedValue = rect
  //    }
  //  }

  //  private var isMarqueeRectEnabled: Bool { behaviour.isMarquee && drawsMarqueeRect }

  //  private func commitRect(_ rect: CGRect?) {
  //    internalRect = rect
  //    if writesBackToBinding {
  //      externalRect?.wrappedValue = rect
  //    }
  //  }

}
