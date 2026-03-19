//
//  TapDragModifier.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 14/1/2026.
//

import SwiftUI

public struct PointerDragModifier: ViewModifier {
  @State private var dragState: DragGestureState

  /// Internal rect — the modifier's own source of truth.
  /// Always kept in sync with the external binding (if any).
  @State private var internalRect: CGRect?

  /// Guards against syncing external changes during a live gesture.
  @State private var isGesturing: Bool = false

  /// External state to observe. In Mode A this is read-write (the modifier
  /// writes back via ``commitRect``). In Mode B this is read-only (sync only).
  private let externalRect: Binding<CGRect?>?

  /// When `true`, ``commitRect`` writes to ``externalRect`` (Mode A).
  /// When `false`, the modifier only updates ``internalRect`` (Mode B).
  private let writesBackToBinding: Bool

  let coordinateSpace: CoordinateSpace
  let behaviour: DragBehavior
  let drawsMarqueeRect: Bool
  let minimumDistance: CGFloat
  let didUpdateEvent: DragEventUpdate

  init(
    rect: Binding<CGRect?>? = nil,
    writesBackToBinding: Bool = true,
    coordinateSpace: CoordinateSpace,
    behaviour: DragBehavior,
    drawsMarqueeRect: Bool,
    minimumDistance: CGFloat,
    didUpdateEvent: @escaping DragEventUpdate = { _, _ in }
  ) {
    self.externalRect = rect
    self.writesBackToBinding = writesBackToBinding
    self.coordinateSpace = coordinateSpace
    self.behaviour = behaviour
    self.drawsMarqueeRect = drawsMarqueeRect
    self.minimumDistance = minimumDistance
    self.didUpdateEvent = didUpdateEvent

    self._dragState = State(initialValue: DragGestureState(behaviour))
    self._internalRect = State(initialValue: rect?.wrappedValue)
  }

  public func body(content: Content) -> some View {
    content
      .gesture(dragGesture, isEnabled: isDragEnabled)
      .drawMarqueeRect(rect: internalRect, isEnabled: isMarqueeRectEnabled)

      .onChange(of: behaviour) { _, newValue in
        dragState.behaviour = newValue
        dragState.end()
        commitRect(nil)
      }

      .onChange(of: externalRect?.wrappedValue) { _, newValue in
        /// External source changed (e.g. reset button, scroll gesture,
        /// programmatic pan). Only adopt when NOT actively gesturing,
        /// to avoid fighting with the live drag.
        guard !isGesturing else { return }
        internalRect = newValue
      }
  }
}

extension PointerDragModifier {
  private var isDragEnabled: Bool { behaviour.isEnabled }
  private var isMarqueeRectEnabled: Bool { behaviour.isMarquee && drawsMarqueeRect }

  /// Writes the rect to internal state and, in Mode A, back to the binding.
  private func commitRect(_ rect: CGRect?) {
    internalRect = rect
    if writesBackToBinding {
      externalRect?.wrappedValue = rect
    }
  }

}
