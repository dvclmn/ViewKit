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
    modifiers: Modifiers,
    currentTransform: TransformState,
  ) -> CanvasAdjustment? {

    switch source {
      case .swipeGesture(let delta, _):
        return handleGlobalSwipe(
          delta: delta,
          modifiers: modifiers,
          currentTransform: currentTransform
        )

      case .pinchGesture(let scale):
        return .updateScale(scale)

      case .continuousHover(let point):
        return .updatePointerHover(point)

      case .pointerTapGesture, .pointerDragGesture:
        /// Pointer events are handled on a per-Tool basis, so break here
        /// to fall through to `handlePointerInteraction`
        /// in `CanvasInteractionState`
        return nil
    }
  }

  private static func handleGlobalSwipe(
    delta: Size<ScreenSpace>,
    //    zoomRange: ClosedRange<Double>,
    modifiers: Modifiers,
    currentTransform: TransformState,
    //    transform: inout TransformState,
  ) -> CanvasAdjustment {

    //    var new = currentTransform

    /// If Option is held during a Swipe, it is interpreted as Zoom, not Pan
    guard modifiers.contains(.option) else {
      let newTranslation = currentTransform.translation + delta
      return .updateTranslation(newTranslation)
      //      new.translation += delta

    }

    /// Each point contributes up to 0.5% zoom change at sensitivity = 1.0
    let factor = ZoomComputation.factorFromDelta(
      CGSize(width: 0, height: delta.cgSize.height),
      weights: .vertical
    )

    let newScale = currentTransform.scale * factor
    //      new.scale = newScale.clamped(to: zoomRange)
    //      new.scale = newScale
    return .updateScale(newScale)

    //    return .updateTransform(new)
  }
}
