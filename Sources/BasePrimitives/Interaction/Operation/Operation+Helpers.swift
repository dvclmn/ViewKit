//
//  Operation+Helpers.swift
//  DrawString
//
//  Created by Dave Coleman on 10/3/2026.
//

extension CanvasOperation {

  /// Gesture-driven operations take priority regardless of tool selection.
  static func resolveGesturePriority(
    from state: CanvasInteraction
  ) -> CanvasOperation? {
    let transform = state.transform
    if transform.zoom.isActive {
      return .zooming(.gesture, phase: transform.zoom.phase)
    }
    if transform.pan.isActive {
      return .panning(.gesture, phase: transform.pan.phase)
    }
    return nil
  }

  /// Resolves an operation based on the currently effective tool and pointer/modifier state.
  static func resolveOperation(
    for tool: CanvasTool,
    isSpringLoaded: Bool,
    state: CanvasInteraction,
    modifiers: Modifiers
  ) -> CanvasOperation {
    let pointer = state.pointer

    switch tool.kind {
      case .select:
        if pointer.drag.isActive {
          return .selecting(SelectionMode(fromModifiers: modifiers), phase: pointer.drag.phase)
        } else if pointer.hover.isActive {
          return .hovering
        } else {
          return .idle
        }

      case .pan:
        guard pointer.drag.isActive else { return .idle }
        return .panning(.pointerDrag, phase: pointer.drag.phase)

      case .zoom:
        /// Gesture-based zoom is handled by resolveGesturePriority.
        /// Pointer-based zoom (click-drag) is not yet implemented.
        return .idle

      case .text:
        guard pointer.drag.isActive else { return .idle }
        return .placingText(phase: pointer.drag.phase)

      default:
        return .idle
    }
  }
}
