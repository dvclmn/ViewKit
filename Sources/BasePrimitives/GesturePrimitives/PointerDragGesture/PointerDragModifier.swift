//
//  TapDragModifier.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 14/1/2026.
//

import SwiftUI

public struct PointerDragModifier: ViewModifier {

  @State private var store: DragHandler
  //  @State private var dragState: DragGestureState

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
  private let externalRect: Binding<CGRect?>?

  /// When `true`, ``commitRect`` writes to ``externalRect`` (Mode A).
  /// When `false`, the modifier only updates ``internalRect`` (Mode B).
  

//  let coordinateSpace: CoordinateSpace
//  let behaviour: DragBehavior
  // TODO:
//  let drawsMarqueeRect: Bool
//  let minimumDistance: CGFloat
//  let didUpdateEvent: DragEventUpdate

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
        dragState: DragGestureState(behaviour),
        internalPayload: payload?.wrappedValue,
        writesBackToBinding: writesBackToBinding,
        coordinateSpace: coordinateSpace,
        minimumDragDistance: minimumDistance
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
        commitRect(nil)
      }

      .onChange(of: externalRect?.wrappedValue) { _, newValue in
        /// External source changed (e.g. reset button, scroll gesture,
        /// programmatic pan). Only adopt when NOT actively gesturing,
        /// to avoid fighting with the live drag.
        guard !isGesturing else { return }
        store.internalRect = newValue
      }
  }
}

extension PointerDragModifier {
  private var isDragEnabled: Bool { store.behaviour.isEnabled }
  private var isMarqueeRectEnabled: Bool { store.behaviour.isMarquee }
//  private var isMarqueeRectEnabled: Bool { behaviour.isMarquee && drawsMarqueeRect }

  /// Writes the rect to internal state and, in Mode A, back to the binding.
  private func commitRect(_ rect: CGRect?) {
    store.internalRect = rect
    if store.writesBackToBinding {
      externalRect?.wrappedValue = rect
    }
  }

}
