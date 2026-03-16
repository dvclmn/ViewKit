//
//  CanvasOperation.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 9/3/2026.
//

/// The semantic operation currently being performed on the canvas.
///
/// Always *computed* from inputs (tool + interaction state + modifiers) — never stored.
///
/// Resolution priority (see `OperationResolver`):
/// 1. Hardware gestures (two-finger trackpad pan/zoom)
/// 2. Spring-loaded pointer actions (e.g. Space → Pan)
/// 3. Standard tool pointer actions
/// 4. Passive hover
///
/// ## Adding domain-specific operations
///
/// 1. Extend the kind:
/// ```swift
/// extension CanvasOperation.Kind {
///   public static let placingText = Self(rawValue: "placingText")
/// }
/// ```
///
/// 2. Add a factory:
/// ```swift
/// extension CanvasOperation {
///   public static func placingText(phase: InteractionPhase) -> CanvasOperation {
///     CanvasOperation(kind: .placingText, phase: phase)
///   }
/// }
/// ```
///
/// 3. Use `userInfo` for domain-specific payload:
/// ```swift
/// CanvasOperation(
///   kind: .selecting,
///   phase: phase,
///   userInfo: ["selectionMode": CellSelectionMode.add]
/// )
/// ```
public struct CanvasOperation: Identifiable {
  public var id: CanvasOperation.Kind { kind }
  public let kind: CanvasOperation.Kind
  public let name: String

  public let phase: InteractionPhase?
//  public let transformSource: TransformSource?

  /// Domain-specific payload. Use this for data like selection modes,
  /// text placement info, etc. that belongs to your app, not the framework.
  public let userInfo: [String: AnyHashable]?

  public init(
    kind: CanvasOperation.Kind,
    name: String? = nil,
    phase: InteractionPhase? = nil,
//    transformSource: TransformSource? = nil,
    userInfo: [String: AnyHashable]? = nil
  ) {
    self.kind = kind
    self.name = name ?? kind.name
    self.phase = phase
//    self.transformSource = transformSource
    self.userInfo = userInfo
  }
}

extension CanvasOperation {
  public var isActive: Bool { phase?.isActive ?? false }
}

// MARK: - Standard factories

extension CanvasOperation {

  public static func idle() -> CanvasOperation {
    CanvasOperation(kind: .idle)
  }

  public static func hovering() -> CanvasOperation {
    CanvasOperation(kind: .hovering)
  }

//  public static func panning(
//    _ src: TransformSource,
//    phase: InteractionPhase
//  ) -> CanvasOperation {
//    CanvasOperation(kind: .panning, phase: phase, transformSource: src)
//  }
//
//  public static func zooming(
//    _ src: TransformSource,
//    phase: InteractionPhase
//  ) -> CanvasOperation {
//    CanvasOperation(kind: .zooming, phase: phase, transformSource: src)
//  }
//
//  public static func selecting(
//    phase: InteractionPhase,
//    userInfo: [String: AnyHashable]? = nil
//  ) -> CanvasOperation {
//    CanvasOperation(kind: .selecting, phase: phase, userInfo: userInfo)
//  }
}
