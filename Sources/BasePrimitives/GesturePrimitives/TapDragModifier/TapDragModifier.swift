//
//  TapDragModifier.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 14/1/2026.
//

import SwiftUI

//public typealias TapUpdate = (CGPoint) -> Void

/// A unified view modifier that handles tap and drag gestures together.
///
/// Supports three drag modes via ``DragBehavior``:
/// - Marquee: draws a transient selection rect, cleared on drag end.
/// - Continuous: accumulates offset across drags (suitable for panning).
/// - None: drag is disabled; tap-only.
public struct UnifiedDragModifier: ViewModifier {
  @State private var dragState: DragGestureState

  @Binding var dragRect: CGRect?
  let coordinateSpace: CoordinateSpace
  let behaviour: DragBehavior
  let drawsMarqueeRect: Bool
  //  let tapCount: Int
  let minimumDistance: CGFloat
  //  let didUpdateTap: TapUpdate

  init(
    rect: Binding<CGRect?>,
    coordinateSpace: CoordinateSpace,
    behaviour: DragBehavior,
    drawsMarqueeRect: Bool,
    //    tapCount: Int,
    minimumDistance: CGFloat,
    //    didUpdateTap: @escaping TapUpdate
  ) {
    self._dragRect = rect
    self.coordinateSpace = coordinateSpace
    self.behaviour = behaviour
    self.drawsMarqueeRect = drawsMarqueeRect
    //    self.tapCount = tapCount
    self.minimumDistance = minimumDistance
    //    self.didUpdateTap = didUpdateTap

    self._dragState = State(initialValue: DragGestureState(behaviour))
  }

  public func body(content: Content) -> some View {
    content
      .gesture(dragGesture, isEnabled: isDragEnabled)
      .drawMarqueeRect(rect: dragRect, isEnabled: isMarqueeRectEnabled)

      .onChange(of: behaviour) { _, newValue in
        dragState.behaviour = newValue
        dragState.end()
        dragRect = nil
      }
  }
}

extension UnifiedDragModifier {
  private var isDragEnabled: Bool { behaviour.isEnabled }
  private var isMarqueeRectEnabled: Bool { behaviour.isMarquee && drawsMarqueeRect }

  private var dragGesture: some Gesture {
    DragGesture(
      minimumDistance: minimumDistance,
      coordinateSpace: coordinateSpace
    )
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
