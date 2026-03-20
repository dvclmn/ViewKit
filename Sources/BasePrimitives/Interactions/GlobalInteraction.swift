//
//  GlobalInteraction.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 19/3/2026.
//

import Foundation

struct GlobalInteraction {
  package static func handleGlobal(
    _ source: InteractionSource,
    zoomRange: ClosedRange<Double>,
    modifiers: Modifiers,
    currentTransform: TransformState,
    //    transform: inout TransformState,
    //    pointer: inout PointerState,
  ) -> CanvasAdjustment {

    switch source {
      case .swipeGesture(let delta, _):
        return handleSwipe(
          delta: delta,
          zoomRange: zoomRange,
          modifiers: modifiers,
          currentTransform: currentTransform
        )

      case .pinchGesture(let scale):
        var new = currentTransform
        new.scale = scale
        return .updateTransform(new)

      case .continuousHover(let point):
        //        pointer.hover = point
        return .updatePointerHover(point)

      case .pointerTapGesture, .pointerDragGesture:
        /// Pointer events are handled on a per-Tool basis, so break here
        /// to fall through to `handlePointerInteraction`
        /// in `CanvasInteractionState`
        return .none
    }
  }

  private static func handleSwipe(
    delta: Size<ScreenSpace>,
    zoomRange: ClosedRange<Double>,
    modifiers: Modifiers,
    currentTransform: TransformState,
    //    transform: inout TransformState,
  ) -> CanvasAdjustment {

    var new = currentTransform

    /// If Option is held during a Swipe, it is interpreted as Zoom, not Pan
    if modifiers.contains(.option) {

      /// Each point contributes up to 0.5% zoom change at sensitivity = 1.0
      let factor = ZoomComputation.factorFromDelta(
        CGSize(width: 0, height: delta.cgSize.height),
        weights: .vertical
      )

      let newScale = currentTransform.scale * factor
      new.scale = newScale.clamped(to: zoomRange)

    } else {
      new.translation += delta

    }
    return .updateTransform(new)
  }
}
