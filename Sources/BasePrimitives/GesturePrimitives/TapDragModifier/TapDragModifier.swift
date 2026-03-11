//
//  TapDragModifier.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 14/1/2026.
//

import SwiftUI

public typealias TapUpdate = (CGPoint) -> Void

/// A unified view modifier that handles tap and drag gestures together.
///
/// Supports three drag modes via ``DragBehavior``:
/// - **Marquee**: draws a transient selection rect, cleared on drag end.
/// - **Continuous**: accumulates offset across drags (suitable for panning).
/// - **None**: drag is disabled; tap-only.
///
/// Prefer the ``View/tapDragGesture(rect:behavior:tapCount:minimumDistance:didUpdateTap:)``
/// family of extensions over constructing this modifier directly.
public struct UnifiedDragModifier: ViewModifier {
  @State private var dragState: DragGestureState
  @Binding var dragRect: CGRect?
  let behavior: DragBehavior
  let tapCount: Int
  let minimumDistance: CGFloat
  let didUpdateTap: TapUpdate

  init(
    rect: Binding<CGRect?>,
    behavior: DragBehavior,
    tapCount: Int,
    minimumDistance: CGFloat,
    didUpdateTap: @escaping TapUpdate
  ) {
    self._dragRect = rect
    self.behavior = behavior
    self.tapCount = tapCount
    self.minimumDistance = minimumDistance
    self.didUpdateTap = didUpdateTap

    self._dragState = State(initialValue: DragGestureState(behavior))
  }

  public func body(content: Content) -> some View {
    content
      .onTapGesture(count: tapCount) { didUpdateTap($0) }
      .gesture(dragGesture, isEnabled: isEnabled)
      .drawMarqueeRect(rect: dragRect, isEnabled: behaviour.isMarquee)
      .onChange(of: behavior) { _, newValue in
        dragState.behaviour = newValue
        dragState.end()
        dragRect = nil
      }
  }
}

extension UnifiedDragModifier {
  private var isEnabled: Bool { behaviour.isEnabled }
  private var behaviour: DragBehavior { dragState.behaviour }

  private var dragGesture: some Gesture {
    DragGesture(minimumDistance: minimumDistance)
      .onChanged { value in

        /// Anchor once per drag. Marquee uses the gesture start location;
        /// continuous uses the current binding offset as the baseline.
        if dragState.anchor == nil {
          dragState.begin(
            with: behaviour.isMarquee
              ? value.startLocation
              : dragRect?.size.toCGPoint
          )
        }

        dragRect = dragState.update(value)
      }

      .onEnded { _ in
        if behaviour.isMarquee {
          dragRect = nil
        }
        dragState.end()
      }
  }
}

extension View {

  /// Adds a unified tap and drag gesture, producing a `CGRect?` binding.
  ///
  /// The rect encodes different values depending on ``DragBehavior``:
  /// - **Marquee**: the selection rect from drag origin to current pointer.
  /// - **Continuous**: the accumulated pan offset in `size`; `origin` is always `.zero`.
  ///
  /// - Parameters:
  ///   - rect: Binding updated throughout the gesture lifecycle.
  ///   - behavior: Controls whether dragging produces a marquee rect or a pan offset.
  ///   - tapCount: Number of taps required to fire `didUpdateTap` (default `1`).
  ///   - minimumDistance: Minimum drag distance before the gesture activates (default `5` pt).
  ///   - didUpdateTap: Called with the tap location in the view's coordinate space.
  public func tapDragGesture(
    rect: Binding<CGRect?>,
    behavior: DragBehavior,
    tapCount: Int = 1,
    minimumDistance: CGFloat = 5,
    didUpdateTap: @escaping TapUpdate = { _ in }
  ) -> some View {
    self.modifier(
      UnifiedDragModifier(
        rect: rect,
        behavior: behavior,
        tapCount: tapCount,
        minimumDistance: minimumDistance,
        didUpdateTap: didUpdateTap
      )
    )
  }

  /// Adds a unified tap and drag gesture, producing a `CGSize?` translation binding.
  ///
  /// A convenience wrapper over ``tapDragGesture(rect:behavior:tapCount:minimumDistance:didUpdateTap:)``
  /// that projects the `size` component of the rect for callers that think in terms of offsets.
  public func tapDragGesture(
    translation: Binding<CGSize?>,
    behavior: DragBehavior,
    tapCount: Int = 1,
    minimumDistance: CGFloat = 5,
    didUpdateTap: @escaping TapUpdate = { _ in }
  ) -> some View {
    self.modifier(
      UnifiedDragModifier(
        rect: translation.toBindingRect,
        behavior: behavior,
        tapCount: tapCount,
        minimumDistance: minimumDistance,
        didUpdateTap: didUpdateTap
      )
    )
  }

  /// Adds a unified tap and drag gesture, projecting drag onto a single scalar axis.
  ///
  /// Useful for one-dimensional controls (sliders, knobs) that only care about
  /// movement along a single axis.
  ///
  /// - Parameters:
  ///   - scalar: Binding that receives the scalar offset along `axis`.
  ///   - axis: The axis to project onto.
  ///   - reversed: When `true`, inverts the sign of the delta (useful for vertical sliders).
  public func tapDragGesture(
    scalar: Binding<CGFloat?>,
    axis: GridAxis,
    reversed: Bool = false,
    tapCount: Int = 1,
    minimumDistance: CGFloat = 5,
    didUpdateTap: @escaping TapUpdate = { _ in }
  ) -> some View {
    self.modifier(
      UnifiedDragModifier(
        rect: scalar.toBindingRect(along: axis, reversed: reversed),
        behavior: .continuous(axes: axis.toSet),
        tapCount: tapCount,
        minimumDistance: minimumDistance,
        didUpdateTap: didUpdateTap
      )
    )
  }
}
