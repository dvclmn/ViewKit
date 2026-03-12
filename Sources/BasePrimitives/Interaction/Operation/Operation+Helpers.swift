//
//  Operation+Helpers.swift
//  DrawString
//
//  Created by Dave Coleman on 10/3/2026.
//

import BasePrimitives
import CanvasKit

extension CanvasOperation {

  /// Resolves gesture-driven operations that take priority regardless of tool selection.
  static func resolveGesturePriority(
    from state: CanvasInteraction
  ) -> CanvasOperation? {
    let transform = state.transform
    if transform.panState.isActive {
      return .active(.panning(.gesture), phase: transform.panState.phase)
    }
    if transform.zoomState.isActive {
      return .active(.zooming(.gesture), phase: transform.zoomState.phase)
    }
    return nil
  }

  /// Resolves an operation based on the currently effective tool and pointer/modifier state.
  static func resolveOperation(
    for tool: Tool,
    isSpringLoaded: Bool,
    state: CanvasInteraction,
    modifiers: Modifiers
  ) -> CanvasOperation {
    let pointer = state.pointer

    switch tool {
      case .select:
        if pointer.dragState.isActive {
          return .active(
            .selecting(SelectionMode(fromModifiers: modifiers)),
            phase: pointer.dragState.phase
          )
        } else if pointer.hoverState.isActive {
          return .hovering
        } else {
          return .idle
        }

      case .pan:
        guard pointer.dragState.isActive else {
          return .idle
        }
        return .active(
          .panning(.pointerDrag(.springLoaded)),
          phase: pointer.dragState.phase
        )

      case .zoom:
        /// Gesture-based zoom handled by resolveGesturePriority.
        /// Pointer-based zoom (click-drag) is not yet implemented.
        return .idle

      case .text:
        guard pointer.dragState.isActive else {
          return .idle
        }
        return .active(.placingText, phase: pointer.dragState.phase)

      case .artboard, .guides: return .idle
    }
  }
}
