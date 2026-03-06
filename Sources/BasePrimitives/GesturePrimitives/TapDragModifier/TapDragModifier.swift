//
//  TapDragModifier.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 14/1/2026.
//

import BasePrimitives
import SwiftUI

/// Goals for unified Tap/Drag modifier
/// - Send tap via callback
/// - Binding CGSize for offset
///
/// Previous separate modifiers
/// - Marquee sent drag back via callback, now Binding
/// - Cumulative used Binding for drag offset

public typealias TapUpdate = (CGPoint) -> Void

public struct UnifiedDragModifier: ViewModifier {
  @State private var dragState: DragGestureState
  @Binding var dragRect: CGRect?
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
  }
}

extension UnifiedDragModifier {
  private var isEnabled: Bool { behaviour.isEnabled }
  private var behaviour: DragBehavior { dragState.behaviour }

  private var dragGesture: some Gesture {
    DragGesture(minimumDistance: minimumDistance)
      .onChanged { value in
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
