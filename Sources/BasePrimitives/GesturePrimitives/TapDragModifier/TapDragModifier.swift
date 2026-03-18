//
//  TapDragModifier.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 14/1/2026.
//

import SwiftUI

/// A unified view modifier that handles tap and drag gestures together.
///
/// Supports three drag modes via ``DragBehavior``:
/// - Marquee: draws a transient selection rect, cleared on drag end.
/// - Continuous: accumulates offset across drags (suitable for panning).
/// - None: drag is disabled; tap-only.
///
/// # Ownership modes
///
/// ## Mode A — Binding (simple)
/// ```swift
/// .pointerDragGesture(rect: $dragRect, behaviour: .marquee)
/// ```
/// The modifier owns the gesture math and writes the result directly to the
/// binding. No event callback — the binding is the single source of truth.
/// External changes to the binding are automatically picked up between
/// gestures (e.g. a reset button clearing the offset).
///
/// ## Mode B — Event callback (advanced)
/// ```swift
/// .pointerDragGesture(behaviour: .marquee) { event, phase in ... }
/// ```
/// The modifier tracks state internally, but the **caller** receives raw
/// ``DragGestureEvent`` values to route through their own pipeline (e.g.
/// tool resolution in CanvasKit). The modifier still handles marquee
/// drawing via its own internal rect.
///
/// To keep the modifier in sync with external state changes (e.g. scroll
/// wheel, programmatic pan), pass the external value via `observing:`:
/// ```swift
/// .pointerDragGesture(
///     observing: $interactionState.dragRect,
///     behaviour: .continuous
/// ) { event, phase in
///     interactionState.handleInput(...)
/// }
/// ```
/// The modifier reads this binding for sync but **never writes** to it,
/// preventing double-writes. The callback is the sole output channel.
///
/// > Important: Do **not** combine a writable binding (Mode A) with an
/// > event callback (Mode B). That creates two writers for the same value.
/// > Use Mode A *or* Mode B, not both.
///
/// # External mutation support
///
/// Both modes handle external mutations to the drag value. When code
/// outside the modifier changes the value (reset button, scroll gesture,
/// programmatic pan), the modifier detects the change and updates its
/// internal baseline. This ensures the next drag gesture starts from the
/// correct position rather than a stale internal value.
///
/// The sync only occurs when the modifier is **not** actively gesturing,
/// to avoid fighting with the live gesture.
public struct UnifiedDragModifier: ViewModifier {
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

extension UnifiedDragModifier {
  private var isDragEnabled: Bool { behaviour.isEnabled }
  private var isMarqueeRectEnabled: Bool { behaviour.isMarquee && drawsMarqueeRect }

  /// Writes the rect to internal state and, in Mode A, back to the binding.
  private func commitRect(_ rect: CGRect?) {
    internalRect = rect
    if writesBackToBinding {
      externalRect?.wrappedValue = rect
    }
  }

  private var dragGesture: some Gesture {
    DragGesture(
      minimumDistance: minimumDistance,
      coordinateSpace: coordinateSpace
    )
      .onChanged { value in
        let isGestureStart = !isGesturing

        if isGestureStart {
          isGesturing = true

          /// Anchor once per drag. Marquee uses the gesture start location;
          /// continuous uses the current internal offset as the baseline.
          dragState.begin(
            with: behaviour.isMarquee
              ? value.startLocation
              : internalRect?.size.toCGPoint
          )
        }

        let proposedRect = dragState.update(value)
        commitRect(proposedRect)

        let event = DragGestureEvent(
          behaviour: behaviour,
          proposedRect: proposedRect,
          startLocation: value.startLocation,
          currentLocation: value.location,
          translation: value.translation,
          isGestureStart: isGestureStart
        )
        didUpdateEvent(event, isGestureStart ? .began : .changed)
      }

      .onEnded { value in
        let proposedRect: CGRect? = behaviour.isMarquee ? nil : internalRect
        commitRect(proposedRect)

        let event = DragGestureEvent(
          behaviour: behaviour,
          proposedRect: proposedRect,
          startLocation: value.startLocation,
          currentLocation: value.location,
          translation: value.translation,
          isGestureStart: false
        )
        didUpdateEvent(event, .ended)

        isGesturing = false
        dragState.end()
      }
  }
}
