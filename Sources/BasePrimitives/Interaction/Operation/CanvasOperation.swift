//
//  Model+CanvasOperation.swift
//  DrawString
//
//  Created by Dave Coleman on 9/3/2026.
//

/// The semantic operation currently being performed on the canvas.
///
/// Always *computed* from inputs — never stored independently. The three
/// layers that feed into it:
///
/// 1. Tool: `ToolHandler.effectiveTool(modifiers:)` (selected tool + spring-loading)
/// 2. Gesture: `TransformState` pan/zoom phases (trackpad gestures take priority)
/// 3. Pointer: `PointerState` drag/hover phases
//enum CanvasOperation: Equatable, Sendable {
//  case idle
//  case hovering
//  case active(Kind, phase: InteractionPhase)
//}

public enum CanvasOperation: Equatable, Sendable {
  case idle
  case hovering

  // Flattened active states
  case panning(TransformSource, phase: InteractionPhase)
  case zooming(TransformSource, phase: InteractionPhase)
  case selecting(SelectionMode, phase: InteractionPhase)
  case placingText(phase: InteractionPhase)
}

extension CanvasOperation {
  init(
    effectiveTool: Tool,
    isSpringLoaded: Bool,
    state: CanvasInteraction,
    modifiers: Modifiers
  ) {
    if let gestureOp = Self.resolveGesturePriority(from: state) {
      self = gestureOp
      return
    }

    self = Self.resolveOperation(
      for: effectiveTool,
      isSpringLoaded: isSpringLoaded,
      state: state,
      modifiers: modifiers
    )
  }
}
extension CanvasOperation {
  var canvasPolicy: CanvasInteractionPolicy {
    switch self {
      case .active(.panning(.pointerDrag), _):
        return .init(
          panGestureEnabled: true,
          zoomGestureEnabled: true,
          dragBehaviour: .continuous,
          hoverEnabled: true)

      case .active(.selecting(_), _):
        return .init(
          panGestureEnabled: true,
          zoomGestureEnabled: true,
          dragBehaviour: .marquee,
          hoverEnabled: true)

      default:
        return .default
    }
  }
}

// MARK: - Display helpers

extension CanvasOperation {

  var name: String {
    switch self {
      case .idle: "Idle"
      case .hovering: "Hovering"
      case .active(let kind, let phase): "\(kind.name), \(phase.name)"
    }
  }

  var phase: InteractionPhase? {
    switch self {
      case .idle, .hovering: nil
      case .active(_, let phase): phase
    }
  }
}
