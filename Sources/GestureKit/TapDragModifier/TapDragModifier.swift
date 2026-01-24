//
//  TapDragModifier.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 14/1/2026.
//

import CoreTools
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
  let isEnabled: Bool
  let tapCount: Int
  let minimumDistance: CGFloat
  let didUpdateTap: TapUpdate

  init(
    rect: Binding<CGRect?>,
    behavior: DragBehavior,
    isEnabled: Bool,
    tapCount: Int,
    minimumDistance: CGFloat,
    didUpdateTap: @escaping TapUpdate,

  ) {
    self._dragRect = rect
    self.isEnabled = isEnabled
    self.tapCount = tapCount
    self.minimumDistance = minimumDistance
    self.didUpdateTap = didUpdateTap

    /// Initialize state based on behavior
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
  private var behaviour: DragBehavior { dragState.behaviour }

  // TODO: Add modifiers, to get different behaviour based on e.g. holding Option, Command, etc
  private var dragGesture: some Gesture {
    DragGesture(minimumDistance: minimumDistance)
      .onChanged { value in

        /// Only anchor once at the very beginning of this specific drag
        if dragState.anchor == nil {
          dragState.begin(

            /// IMPORTANT: Not sure if I should use `dragRect.origin`,
            /// or the *size* (and convert to CGPoint)
            with: behaviour.isMarquee
              ? value.startLocation
              : dragRect?.size.toCGPoint
          )
        }

        dragRect = dragState.update(value)
      }

      .onEnded { value in
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
    isEnabled: Bool = true,
    minimumDistance: CGFloat = 5,
    didUpdateTap: @escaping TapUpdate = { _ in },
  ) -> some View {
    self.modifier(
      UnifiedDragModifier(
        rect: rect,
        behavior: behavior,
        isEnabled: isEnabled,
        tapCount: tapCount,
        minimumDistance: minimumDistance,
        didUpdateTap: didUpdateTap,
      )
    )
  }

  public func tapDragGesture(
    translation: Binding<CGSize?>,
    behavior: DragBehavior,
    tapCount: Int = 1,
    isEnabled: Bool = true,
    minimumDistance: CGFloat = 5,
    didUpdateTap: @escaping TapUpdate = { _ in },
  ) -> some View {
    self.modifier(
      UnifiedDragModifier(
        rect: translation.toBindingRect,
        behavior: behavior,
        isEnabled: isEnabled,
        tapCount: tapCount,
        minimumDistance: minimumDistance,
        didUpdateTap: didUpdateTap,
      )
    )
  }
}
