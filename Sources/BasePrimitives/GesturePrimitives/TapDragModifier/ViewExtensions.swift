//
//  ViewExtensions.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 13/3/2026.
//

import SwiftUI

// MARK: - Mode A: Binding (simple)

/// The modifier owns drag state and writes results to the binding.
/// External changes to the binding (e.g. reset, programmatic pan) are
/// automatically picked up between gestures.

extension View {

  /// Adds a unified tap and drag gesture, producing a `CGRect?` binding.
  ///
  /// The rect encodes different values depending on ``DragBehavior``:
  /// - **Marquee**: the selection rect from drag origin to current pointer.
  /// - **Continuous**: the accumulated pan offset in `size`; `origin` is always `.zero`.
  ///
  /// The modifier writes computed values to the binding and reads it back
  /// for baseline sync — making the binding the single source of truth.
  public func onPointerDragGesture(
    rect: Binding<CGRect?>,
    coordinateSpace: CoordinateSpace = .local,
    behaviour: DragBehavior,
    drawsMarqueeRect: Bool = true,
    minimumDistance: CGFloat = 5
  ) -> some View {
    self.modifier(
      PointerDragModifier(
        rect: rect,
        writesBackToBinding: true,
        coordinateSpace: coordinateSpace,
        behaviour: behaviour,
        drawsMarqueeRect: drawsMarqueeRect,
        minimumDistance: minimumDistance
      )
    )
  }

  /// Adds a unified tap and drag gesture, producing a `CGSize?` translation binding.
  ///
  /// A convenience wrapper that projects the `size` component of the rect
  /// for callers that think in terms of offsets.
  public func onPointerDragGesture(
    translation: Binding<CGSize?>,
    coordinateSpace: CoordinateSpace = .local,
    behaviour: DragBehavior,
    drawsMarqueeRect: Bool = true,
    minimumDistance: CGFloat = 5
  ) -> some View {
    self.modifier(
      PointerDragModifier(
        rect: translation.toBindingRect,
        writesBackToBinding: true,
        coordinateSpace: coordinateSpace,
        behaviour: behaviour,
        drawsMarqueeRect: drawsMarqueeRect,
        minimumDistance: minimumDistance
      )
    )
  }

  /// Adds a unified tap and drag gesture, projecting drag onto a single scalar axis.
  ///
  /// Useful for one-dimensional controls (sliders, knobs) that only care about
  /// movement along a single axis.
  public func onPointerDragGesture(
    scalar: Binding<CGFloat?>,
    coordinateSpace: CoordinateSpace = .local,
    axis: GridAxis,
    reversed: Bool = false,
    minimumDistance: CGFloat = 5
  ) -> some View {
    self.modifier(
      PointerDragModifier(
        rect: scalar.toBindingRect(along: axis, reversed: reversed),
        writesBackToBinding: true,
        coordinateSpace: coordinateSpace,
        behaviour: .continuous(axes: axis.toSet),
        drawsMarqueeRect: false,
        minimumDistance: minimumDistance
      )
    )
  }
}

// MARK: - Mode B: Event callback (advanced)
//
/// The caller owns drag state. The modifier tracks gesture mechanics
/// internally (anchor, accumulation, marquee drawing) and sends events;
/// the callback receives raw data to route through a tool/interaction
/// pipeline.
///
/// External sync: Pass a binding via `observing:` so the modifier can
/// pick up changes made outside the gesture (scroll wheel, reset button,
/// programmatic pan). The modifier reads this binding but never writes
/// to it — the callback is the sole output channel.

extension View {

  /// Event-driven drag with full ``DragGestureEvent`` context.
  ///
  /// The modifier still handles marquee drawing and continuous accumulation
  /// internally. The callback provides raw event data for routing through
  /// a custom interaction pipeline.
  ///
  /// - Parameter observing: Optional binding to the external source of truth.
  ///   The modifier **reads** this to stay in sync with external mutations
  ///   (e.g. scroll wheel changing the pan offset) but **never writes** to it.
  ///   Pass `nil` (the default) when external sync is not needed.
  public func onPointerDragGesture(
    observing rect: Binding<CGRect?>? = nil,
    coordinateSpace: CoordinateSpace = .local,
    behaviour: DragBehavior,
    drawsMarqueeRect: Bool = true,
    minimumDistance: CGFloat = 5,
    didUpdateEvent: @escaping DragEventUpdate
  ) -> some View {
    self.modifier(
      PointerDragModifier(
        rect: rect,
        writesBackToBinding: false,
        coordinateSpace: coordinateSpace,
        behaviour: behaviour,
        drawsMarqueeRect: drawsMarqueeRect,
        minimumDistance: minimumDistance,
        didUpdateEvent: didUpdateEvent
      )
    )
  }

  /// Simplified event-driven drag receiving just `(proposedRect, phase)`.
  ///
  /// Convenience wrapper for callers that don't need the full event context.
  ///
  /// - Parameter observing: Optional binding for external sync (read-only).
  public func onPointerDragGesture(
    observing rect: Binding<CGRect?>? = nil,
    coordinateSpace: CoordinateSpace = .local,
    behaviour: DragBehavior,
    drawsMarqueeRect: Bool = true,
    minimumDistance: CGFloat = 5,
    didUpdateDrag: @escaping DragUpdate
  ) -> some View {
    self.modifier(
      PointerDragModifier(
        rect: rect,
        writesBackToBinding: false,
        coordinateSpace: coordinateSpace,
        behaviour: behaviour,
        drawsMarqueeRect: drawsMarqueeRect,
        minimumDistance: minimumDistance,
        didUpdateEvent: { event, phase in
          didUpdateDrag(event.proposedRect, phase)
        }
      )
    )
  }
}
