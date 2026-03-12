//
//  OperationResolver.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 12/3/2026.
//

import SwiftUI

public struct OperationState {
  let tool: CanvasTool
  let modifiers: Modifiers
  let key: KeyEquivalent?
  let operation: CanvasOperation?
//  let keyboardKey: KeyboardKey
}

//public enum KeyboardKey {
//  case modifiers(Modifiers)
//  case key(KeyEquivalent)
//}


public struct OperationResolver {

  /// Evaluates current state and returns the single operation the canvas should perform.
  ///
  /// Priority layers (first match wins):
  /// 1. Global hardware gestures (two-finger trackpad pan/zoom)
  /// 2. Spring-loaded pointer actions (e.g. Space → Pan tool)
  /// 3. Standard tool pointer actions (drag/tap)
  /// 4. Passive hover
  public static func resolve(
    state: CanvasInteractionState,
    activeTool: CanvasTool,
    springLoadedTool: CanvasTool?,
    modifiers: Modifiers
  ) -> CanvasOperation {

    // Layer 1: Global Hardware Gestures
    if let gestureOp = resolveGesture(from: state.transform) {
      return gestureOp
    }

    // Layer 2: Spring-Loaded Pointer Actions
    if let springTool = springLoadedTool, state.pointer.drag.isActive {
      return resolvePointer(for: springTool, pointer: state.pointer, modifiers: modifiers)
    }

    // Layer 3: Standard Tool Pointer Actions
    if state.pointer.drag.isActive || state.pointer.tap.isActive {
      return resolvePointer(for: activeTool, pointer: state.pointer, modifiers: modifiers)
    }

    // Layer 4: Passive Hover
    if state.pointer.hover.isActive {
      return .hovering
    }

    return .idle
  }

  // MARK: - Private

  private static func resolveGesture(from transform: TransformState) -> CanvasOperation? {
    // Zoom takes priority over pan when simultaneous
    if transform.zoom.isActive {
      return .zooming(.gesture, phase: transform.zoom.phase)
    }
    if transform.pan.isActive {
      return .panning(.gesture, phase: transform.pan.phase)
    }
    return nil
  }

  private static func resolvePointer(
    for tool: CanvasTool,
    pointer: PointerState,
    modifiers: Modifiers
  ) -> CanvasOperation {
    switch tool.kind {
      case .pan:
        return .panning(.pointerDrag, phase: pointer.drag.phase)
      case .select:
        return .selecting(SelectionMode(fromModifiers: modifiers), phase: pointer.drag.phase)
      case .text:
        return .placingText(phase: pointer.drag.phase)
      default:
        return .idle
    }
  }
}
