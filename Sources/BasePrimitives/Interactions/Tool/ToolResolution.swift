//
//  ToolResolution.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 18/3/2026.
//


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
