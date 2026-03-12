//
//  Model+CanvasOperation.swift
//  DrawString
//
//  Created by Dave Coleman on 9/3/2026.
//

/// The semantic operation currently being performed on the canvas.
///
/// Always *computed* from inputs — never stored independently.
///
/// Resolution priority (see `OperationResolver`):
/// 1. Hardware gestures (two-finger trackpad pan/zoom)
/// 2. Spring-loaded pointer actions (e.g. Space → Pan)
/// 3. Standard tool pointer actions
/// 4. Passive hover
public enum CanvasOperation: Equatable, Sendable {
  case idle
  case hovering
  case panning(TransformSource, phase: InteractionPhase)
  case zooming(TransformSource, phase: InteractionPhase)
  case selecting(SelectionMode, phase: InteractionPhase)
  case placingText(phase: InteractionPhase)
}

// MARK: - Initialiser

extension CanvasOperation {
  public init(
    effectiveTool: CanvasTool,
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

// MARK: - Display helpers

extension CanvasOperation {

  public var name: String {
    switch self {
      case .idle:                          "Idle"
      case .hovering:                      "Hovering"
      case .panning(let src, _):           "Panning (\(src.name))"
      case .zooming(let src, _):           "Zooming (\(src.name))"
      case .selecting(let mode, _):        "Selecting (\(mode.name))"
      case .placingText:                   "Placing Text"
    }
  }

  public var phase: InteractionPhase? {
    switch self {
      case .idle, .hovering:                         nil
      case .panning(_, let phase):                   phase
      case .zooming(_, let phase):                   phase
      case .selecting(_, let phase):                 phase
      case .placingText(let phase):                  phase
    }
  }

  public var isActive: Bool {
    phase?.isActive ?? false
  }
}
