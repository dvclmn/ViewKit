//
//  Model+CanvasOperation.swift
//  DrawString
//
//  Created by Dave Coleman on 9/3/2026.
//

public struct CanvasOperation: Identifiable {
  public var id: CanvasOperation.Kind { kind }
  public let kind: CanvasOperation.Kind
  public let name: String

  // Optional payload fields used by common operations.
  public let phase: InteractionPhase?
  public let transformSource: TransformSource?
  public let selectionMode: CellSelectionMode?

  // Optional metadata bag for domain-specific data if needed.
  public let userInfo: [String: AnyHashable]?

  /// If no `name` supplied, will default to deriving from `kind`
  public init(
    kind: CanvasOperation.Kind,
    name: String? = nil,
    phase: InteractionPhase? = nil,
    transformSource: TransformSource? = nil,
    selectionMode: CellSelectionMode? = nil,
    userInfo: [String: AnyHashable]? = nil
  ) {
    self.kind = kind
    self.name = name ?? kind.name
    self.phase = phase
    self.transformSource = transformSource
    self.selectionMode = selectionMode
    self.userInfo = userInfo
  }
}

extension CanvasOperation {
  public init(
    effectiveTool: CanvasTool,
    isSpringLoaded: Bool,
    state: CanvasInteractionState,
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

  public var isActive: Bool { phase?.isActive ?? false }

}
extension CanvasOperation {

  public static func idle() -> CanvasOperation {
    CanvasOperation(kind: .idle)
  }

  public static func hovering() -> CanvasOperation {
    CanvasOperation(kind: .hovering)
  }

  public static func panning(
    _ src: TransformSource,
    phase: InteractionPhase
  ) -> CanvasOperation {
    CanvasOperation(kind: .panning, phase: phase, transformSource: src)
  }

  public static func zooming(
    _ src: TransformSource,
    phase: InteractionPhase
  ) -> CanvasOperation {
    CanvasOperation(kind: .zooming, phase: phase, transformSource: src)
  }

  public static func selecting(
    _ mode: CellSelectionMode,
    phase: InteractionPhase
  ) -> CanvasOperation {
    CanvasOperation(kind: .selecting, phase: phase, selectionMode: mode)
  }

  // Domain-specific example:
  //  public static func placingText(phase: InteractionPhase) -> CanvasOperation {
  //    CanvasOperation(kind: .init(rawValue: "placingText"), phase: phase)
  //  }
}

//public struct CanvasOperation: Identifiable {
//  public var id: CanvasOperation.Kind { kind }
//  let kind: CanvasOperation.Kind
//  let name: String
//  //  let kind: CanvasToolKind
//}

/// The semantic operation currently being performed on the canvas.
///
/// Always *computed* from inputs — never stored independently.
///
/// Resolution priority (see `OperationResolver`):
/// 1. Hardware gestures (two-finger trackpad pan/zoom)
/// 2. Spring-loaded pointer actions (e.g. Space → Pan)
/// 3. Standard tool pointer actions
/// 4. Passive hover
public enum CanvasOperationLegacy: Equatable, Sendable {
  case idle
  case hovering
  case panning(TransformSource, phase: InteractionPhase)
  case zooming(TransformSource, phase: InteractionPhase)
  case selecting(CellSelectionMode, phase: InteractionPhase)
  case placingText(phase: InteractionPhase)
}

//extension CanvasOperation {

//  public var name: String {
//    switch self {
//      case .idle: "Idle"
//      case .hovering: "Hovering"
//      case .panning(let src, _): "Panning (\(src.name))"
//      case .zooming(let src, _): "Zooming (\(src.name))"
//      case .selecting(let mode, _): "Selecting (\(mode.name))"
//      case .placingText: "Placing Text"
//    }
//  }

//  public var phase: InteractionPhase? {
//    switch self {
//      case .idle, .hovering: nil
//      case .panning(_, let phase): phase
//      case .zooming(_, let phase): phase
//      case .selecting(_, let phase): phase
//      case .placingText(let phase): phase
//    }
//  }

//}
