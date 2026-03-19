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
//  let behaviour: DragBehavior
  let drawsMarqueeRect: Bool
  let minimumDistance: CGFloat
  let didUpdateEvent: DragEventUpdate

  init(
    payload: Binding<PointerDragPayload?>?,
    //    rect: Binding<CGRect?>? = nil,
    writesBackToBinding: Bool = true,
    coordinateSpace: CoordinateSpace,
    behaviour: DragBehavior,
//    drawsMarqueeRect: Bool,
    minimumDistance: CGFloat,
    didUpdateEvent: @escaping DragEventUpdate = { _, _ in }
  ) {
    //    self.externalRect = rect
//    self.writesBackToBinding = writesBackToBinding
//    self.coordinateSpace = coordinateSpace
//    self.behaviour = behaviour
//    self.drawsMarqueeRect = drawsMarqueeRect
//    self.minimumDistance = minimumDistance
//    self.didUpdateEvent = didUpdateEvent

    self._store = State(
      initialValue: DragHandler(
        externalPayload: payload,
        internalPayload: <#T##PointerDragPayload?#>
        dragState: DragGestureState(behaviour),
        writesBackToBinding: writesBackToBinding,
        coordinateSpace: coordinateSpace,
        minimumDragDistance: minimumDistance,
      )
    )
    //    self._dragState = State(initialValue: DragGestureState(behaviour))
    //    self._internalRect = State(initialValue: rect?.wrappedValue)
  }

  public func body(content: Content) -> some View {
    content
      .gesture(PointerDrag(store: store), isEnabled: isDragEnabled)
//      .gesture(store.dragGesture, isEnabled: isDragEnabled)
      .drawMarqueeRect(rect: store.internalPayload?.boundingRect, isEnabled: isMarqueeRectEnabled)
//      .drawMarqueeRect(rect: internalRect, isEnabled: isMarqueeRectEnabled)

      .onChange(of: store.behaviour) { _, newValue in
        store.dragState.behaviour = newValue
        store.dragState.end()
        store.commitPayload(nil, external: externalPayload)
      }

      .onChange(of: externalPayload?.wrappedValue) { _, newValue in
        /// External source changed (e.g. reset button, scroll gesture,
        /// programmatic pan). Only adopt when NOT actively gesturing,
        /// to avoid fighting with the live drag.
        guard !isGesturing else { return }
        store.internalRect = newValue
      }
      .task(id: writesb) {}
  }
}

extension PointerDragModifier {
  
  private var dragGesture: some Gesture {
    DragGesture(
      minimumDistance: store.minimumDragDistance,
      coordinateSpace: store.coordinateSpace
    )
    .onChanged { value in
      let isGestureStart = !store.isGesturing
      
      if isGestureStart {
        store.isGesturing = true
        
        /// Anchor once per drag. Marquee uses the gesture start location;
        /// continuous uses the current internal offset as the baseline.
        store.dragState.begin(
          with: store.behaviour.isMarquee
          ? value.startLocation
          : store.internalPayload?.size.toCGPoint
        )
      }
      
      let proposed = store.dragState.update(value)
      store.commitRect(proposed?.boundingRect)
      
      //      let event = DragGestureEvent(
      //        behaviour: behaviour,
      //        proposedRect: proposedRect,
      //        startLocation: value.startLocation,
      //        currentLocation: value.location,
      //        translation: value.translation,
      //        isGestureStart: isGestureStart
      //      )
      
      store.didUpdateEvent(store.internalPayload, isGestureStart ? .began : .changed)
    }
    
    .onEnded { value in
      let proposedRect: CGRect? = store.behaviour.isMarquee ? nil : store.internalRect
      store.commitRect(proposedRect)
      
      //      let event = DragGestureEvent(
      //        behaviour: behaviour,
      //        proposedRect: proposedRect,
      //        startLocation: value.startLocation,
      //        currentLocation: value.location,
      //        translation: value.translation,
      //        isGestureStart: false
      //      )
      store.didUpdateEvent(event, .ended)
      
      isGesturing = false
      dragState.end()
    }
  }
//  }
  

  private var isDragEnabled: Bool { store.behaviour.isEnabled }
  private var isMarqueeRectEnabled: Bool { store.behaviour.isMarquee }

/// Writes the rect to internal state and, in Mode A, back to the binding.
func commitPayload(
  _ payload: PointerDragPayload?,
  external: Binding<PointerDragPayload?>?,
) {
  //    internalRect = payload?.boundingRect
  internalPayload = payload
  
  if writesBackToBinding {
    external?.wrappedValue = payload
    //      externalPayload?.wrappedValue = payload
    //      externalRect?.wrappedValue = payload?.boundingRect
  }
}
//  func commitRect(_ rect: CGRect?) {
//    store.internalRect = rect
//    if store.writesBackToBinding {
//      externalRect?.wrappedValue = rect
//    }
//  }

var behaviour: DragBehavior { dragState.behaviour }
//  private var isMarqueeRectEnabled: Bool { behaviour.isMarquee && drawsMarqueeRect }


//  private func commitRect(_ rect: CGRect?) {
//    internalRect = rect
//    if writesBackToBinding {
//      externalRect?.wrappedValue = rect
//    }
//  }

}
