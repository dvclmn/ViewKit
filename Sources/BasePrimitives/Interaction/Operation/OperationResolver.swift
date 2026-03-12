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

//public struct EffectiveCanvasTool {
//  let tool: CanvasTool
//  let springLoaded: CanvasTool?
//}

//public enum KeyboardKey {
//  case modifiers(Modifiers)
//  case key(KeyEquivalent)
//}

public struct OperationResolver {

  /// Evaluates current state and returns the single operation the canvas should perform.
  public static func resolve(
    state: CanvasInteractionState,
    //    tool: EffectiveCanvasTool,
    activeTool: CanvasTool,
    springLoadedTool: CanvasTool?,
    modifiers: Modifiers
  ) -> CanvasOperation {

    /// Layer 1: Global Hardware Gestures (two-finger trackpad pan/zoom)
    if let gestureOperation = resolveGesture(from: state.transform) {
      return gestureOperation
    }

    /// Layer 2: Spring-Loaded Pointer Actions  (e.g. Space → Pan tool)
    if let springLoadedTool {
//    if let springLoaded = springLoadedTool, state.pointer.drag.isActive {
      return resolvePointer(
        for: springLoadedTool,
        state: state.pointer,
        modifiers: modifiers
      )
    }

    /// Layer 3: Standard Tool Pointer Actions (drag/tap)
    if state.pointer.drag.isActive || state.pointer.tap.isActive {
      return resolvePointer(
        for: activeTool,
        state: state.pointer,
        modifiers: modifiers
      )
    }

    /// Layer 4: Passive Hover
    if state.pointer.hover.isActive {
      return .hovering
    }

    return .idle
  }

  // MARK: - Private

  private static func resolveGesture(from transform: TransformState) -> CanvasOperation? {
    /// Zoom takes priority over pan when simultaneous
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
    state: PointerState,
    modifiers: Modifiers
  ) -> CanvasOperation {

    switch tool.kind {
      case .pan: .panning(.pointerDrag, phase: state.drag.phase)
      case .select: .selecting(SelectionMode(fromModifiers: modifiers), phase: state.drag.phase)
      case .text: .placingText(phase: state.drag.phase)
      default: .idle
    }
  }
}
