//
//  GlobalInteraction.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 19/3/2026.
//

import Foundation

struct GlobalInteraction {
  package static func handleGlobalInteraction(
    _ source: InteractionSource,
    zoomRange: ClosedRange<Double>,
    modifiers: Modifiers,
    transform: inout TransformState,
    pointer: inout PointerState,
  ) {

    switch source {
      case .swipeGesture(let delta, _):
        handleSwipe(
          delta: delta,
          zoomRange: zoomRange,
          modifiers: modifiers,
          transform: &transform
        )

      case .pinchGesture(let scale):
        transform.scale = scale

      case .continuousHover(let point):
        pointer.hover = point

      case .pointerTapGesture, .pointerDragGesture:
        /// Pointer events are handled on a per-Tool basis, so break here
        /// to fall through to `handlePointerInteraction`
        /// in `CanvasInteractionState`
        break
    }
  }

  private static func handleSwipe(
    delta: Size<ScreenSpace>,
    zoomRange: ClosedRange<Double>,
    modifiers: Modifiers,
    transform: inout TransformState,
  ) {

    /// If Option is held during a Swipe, it is interpreted as Zoom, not Pan
    if modifiers.contains(.option) {

      /// Each point contributes up to 0.5% zoom change at sensitivity = 1.0
      let factor = ZoomComputation.factorFromDelta(
        CGSize(width: 0, height: delta.cgSize.height),
        weights: .vertical
      )
      var new = transform
      let newScale = transform.scale * factor
      new.scale = newScale.clamped(to: zoomRange)
      transform = new

    } else {
      var new = transform
      new.translation += delta
      transform = new
    }
  }
}
