//
//  OperationResolver.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 12/3/2026.
//

import SwiftUI

/// Computes the single `CanvasOperation` from the current interaction state,
/// active tool, and modifier keys.
///
/// ## Priority layers
/// 1. Hardware gestures (two-finger trackpad pan/zoom) — always win
/// 2. Spring-loaded pointer actions (e.g. Space → Pan tool)
/// 3. Standard tool pointer actions (drag/tap with the selected tool)
/// 4. Passive hover
///
/// ## Domain-specific tools
///
/// The `default` case returns `.idle()`. To handle custom tool kinds,
/// override resolution in your domain by calling `resolve()` and
/// post-processing the result, or by extending this type.
public struct OperationResolver {

  public static func resolve(
    state: CanvasInteractionState,
    activeTool: CanvasTool,
    springLoadedTool: CanvasTool?,
    modifiers: Modifiers
  ) -> CanvasOperation {

    // Layer 1: Global Hardware Gestures
    if let gestureOperation = resolveGesturePriority(from: state) {
      return gestureOperation
    }

    // Layer 2: Spring-Loaded Pointer Actions
    if let springLoadedTool {
      return resolveOperation(
        for: springLoadedTool,
        state: state,
        modifiers: modifiers
      )
    }

    // Layer 3: Standard Tool Pointer Actions
    if state.pointer.drag.isActive || state.pointer.tap.isActive {
      return resolveOperation(
        for: activeTool,
        state: state,
        modifiers: modifiers
      )
    }

    // Layer 4: Passive Hover
    if state.pointer.hover.isActive {
      return .hovering()
    }

    return .idle()
  }

  /// Gesture-driven operations take priority regardless of tool selection.
  static func resolveGesturePriority(
    from state: CanvasInteractionState
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
    state: CanvasInteractionState,
    modifiers: Modifiers
  ) -> CanvasOperation {

    let pointer = state.pointer

    switch tool.kind {

      case .select:
        if pointer.drag.isActive {
          return .selecting(phase: pointer.drag.phase)
        } else if pointer.hover.isActive {
          return .hovering()
        } else {
          return .idle()
        }

      case .pan:
        guard pointer.drag.isActive else { return .idle() }
        return .panning(.pointerDrag, phase: pointer.drag.phase)

      case .zoom:
        // Click-drag: continuous vertical drag maps to zoom in/out.
        if pointer.drag.isActive {
          return .zooming(.pointerDrag, phase: pointer.drag.phase)
        }
        // Click (no drag): step zoom at pointer location.
        if pointer.tap.isActive {
          return .zooming(.pointerDrag, phase: pointer.tap.phase)
        }
        return .idle()

      default:
        return .idle()
    }
  }
}
