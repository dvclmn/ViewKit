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
    if let gestureOperation = resolveGesturePriority(from: state) {
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

  private static func resolvePointer(
    for tool: CanvasTool,
    state: PointerState,
    modifiers: Modifiers
  ) -> CanvasOperation {

    switch tool.kind {
      case .pan: .panning(.pointerDrag, phase: state.drag.phase)
      case .select: .selecting(CellSelectionMode(fromModifiers: modifiers), phase: state.drag.phase)
      case .text: .placingText(phase: state.drag.phase)
      default: .idle
    }
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
    isSpringLoaded: Bool,
    state: CanvasInteractionState,
    modifiers: Modifiers
  ) -> CanvasOperation {
    
    let pointer = state.pointer
    
    switch tool.kind {
        
      case .select:
        if pointer.drag.isActive {
          return .selecting(
            CellSelectionMode(fromModifiers: modifiers),
            phase: pointer.drag.phase
          )
        } else if pointer.hover.isActive {
          return .hovering()
        } else {
          return .idle()
        }
        
      case .pan:
        guard pointer.drag.isActive else { return .idle() }
        return .panning(.pointerDrag, phase: pointer.drag.phase)
        
      case .zoom:
        /// Gesture-based zoom is handled by resolveGesturePriority.
        /// Pointer-based zoom (click-drag) is not yet implemented.
        return .idle()
        
        //      case .text:
        //        guard pointer.drag.isActive else { return .idle() }
        //        return .placingText(phase: pointer.drag.phase)
        
      default:
        return .idle()
    }
  }

}
