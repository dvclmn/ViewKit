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

        /// Option + swipe = zoom
        if modifiers.contains(.option) {

          /// `sensitivity`: zoom change per swipe point
          /// Aka each pixel contributes 0.5% zoom change
          let sensitivity: Double = 0.005

          let zoomDelta = 1.0 + (delta.cgSize.height * sensitivity)
          var new = transform
          let newScale = transform.scale * zoomDelta
          new.scale = newScale.clamped(to: zoomRange)
          transform = new

        } else {
          var new = transform
          new.translation += delta
          transform = new
        }
        return

      case .pinchGesture(let event):
        var new = transform
        new.scale = event.magnification.clamped(to: zoomRange)

        transform = new
        return

      case .continuousHover(let point):
        pointer.hover = point
        return

      case .pointerTapGesture, .pointerDragGesture:
        /// Pointer events are handled on a per-Tool basis, so break here
        /// to fall through to `handlePointerInteraction`
        /// in `CanvasInteractionState`
        break
    }
  }
}
