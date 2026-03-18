//
//  ToolAction.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 18/3/2026.
//

import Foundation

/// Domain-level actions that tools can produce alongside canvas-level intents.
///
/// While `CanvasIntent` handles canvas state mutations (transform, pointer state),
/// `ToolAction` represents higher-level domain actions that the consuming app
/// is responsible for interpreting.
///
/// For example, a Select tool might produce `.selectAt(point)`, while a
/// drawing tool might produce `.commitStroke(points)`. CanvasKit doesn't
/// know what these mean — it just passes them through to the app's handler.
///
/// Usage:
/// ```swift
/// extension ToolAction {
///   static func selectAt(_ point: Point<CanvasSpace>) -> ToolAction {
///     .custom("selectAt", payload: point)
///   }
/// }
/// ```
public enum ToolAction: Sendable {
  /// A domain-specific action identified by name, with an optional payload.
  case custom(String, payload: (any Sendable)? = nil)

  /// No domain action.
  case none
}

/// The combined result of a tool resolving a pointer interaction.
///
/// Separates canvas-level state changes (`intent`) from domain-level
/// actions (`action`) so that `CanvasInteractionState` can execute the
/// intent immediately, while the consuming app handles the action.
public struct ToolResolution: Sendable {
  public let intent: CanvasIntent
  public let action: ToolAction

  public init(
    intent: CanvasIntent = .none,
    action: ToolAction = .none
  ) {
    self.intent = intent
    self.action = action
  }

  /// Convenience for returning just a canvas intent with no domain action.
  public static func intent(_ intent: CanvasIntent) -> Self {
    .init(intent: intent)
  }

  /// Convenience for returning just a domain action with no canvas change.
  public static func action(_ action: ToolAction) -> Self {
    .init(action: action)
  }

  public static let none = Self()
}
