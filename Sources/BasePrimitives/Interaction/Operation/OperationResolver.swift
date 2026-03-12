//
//  OperationResolver.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 12/3/2026.
//

public struct OperationResolver {
  
  /// Evaluates current state and returns the strict, single operation the canvas should perform.
  public static func resolve(
    state: CanvasInteraction,
    activeTool: Tool,
    springLoadedTool: Tool?,
    modifiers: Modifiers
  ) -> CanvasOperation {
    
    // Layer 1: Global Hardware Gestures (Wins immediately)
    // e.g., Two-finger trackpad pan/zoom
    if let gestureOp = resolveGesture(from: state.transform) {
      return gestureOp
    }
    
    // Layer 2: Spring-Loaded Pointer Actions
    // e.g., Holding spacebar temporarily activates the Pan tool
    if let springTool = springLoadedTool, state.pointer.dragState.isActive {
      return resolvePointer(for: springTool, pointer: state.pointer, modifiers: modifiers, isSpringLoaded: true)
    }
    
    // Layer 3: Standard Tool Pointer Actions
    if state.pointer.dragState.isActive || state.pointer.tapState.isActive {
      return resolvePointer(for: activeTool, pointer: state.pointer, modifiers: modifiers, isSpringLoaded: false)
    }
    
    // Layer 4: Passive Hover
    if state.pointer.hoverState.isActive {
      return .hovering
    }
    
    return .idle
  }
  
  private static func resolveGesture(from transform: TransformState) -> CanvasOperation? {
    // Evaluate gestures in their own micro-priority (e.g., Zoom usually dictates Pan if simultaneous)
    if transform.zoomState.isActive {
      return .zooming(.gesture, phase: transform.zoomState.phase)
    }
    if transform.panState.isActive {
      return .panning(.gesture, phase: transform.panState.phase)
    }
    return nil
  }
  
  private static func resolvePointer(for tool: Tool, pointer: PointerState, modifiers: Modifiers, isSpringLoaded: Bool) -> CanvasOperation {
    let source: TransformSource = .pointerDrag(isSpringLoaded ? .springLoaded : .standard)
    
    switch tool {
      case .pan:
        return .panning(source, phase: pointer.dragState.phase)
      case .select:
        return .selecting(SelectionMode(fromModifiers: modifiers), phase: pointer.dragState.phase)
      case .text:
        return .placingText(phase: pointer.dragState.phase)
      default:
        return .idle
    }
  }
}
