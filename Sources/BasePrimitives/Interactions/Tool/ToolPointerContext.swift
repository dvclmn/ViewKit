//
//  ToolPointerContext.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 18/3/2026.
//

import Foundation

/// Context used by tools to resolve a pointer style for the current interaction state.
public struct ToolPointerContext: Sendable {

  /// Current modifier keys state.
  public let modifiers: Modifiers

  /// The most recent pointer interaction phase.
  public let pointerPhase: InteractionPhase

  /// The most recent pointer interaction source, if any.
  public let pointerSource: InteractionSource?

  public init(
    modifiers: Modifiers,
    pointerPhase: InteractionPhase = .none,
    pointerSource: InteractionSource? = nil
  ) {
    self.modifiers = modifiers
    self.pointerPhase = pointerPhase
    self.pointerSource = pointerSource
  }
}

extension ToolPointerContext {
  /// True when the last pointer interaction is an active drag.
  public var isPointerDragging: Bool {
    guard case .pointerDragGesture? = pointerSource else { return false }
    return pointerPhase.isActive
  }
}
