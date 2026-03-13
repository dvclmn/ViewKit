//
//  ToolBehaviour.swift
//  DrawString
//
//  Created by Dave Coleman on 10/3/2026.
//

import SwiftUI

public struct KeyBinding: Hashable, Sendable {
  public let key: KeyEquivalent
  public let requiredModifiers: Modifiers
  
  public init(
    key: KeyEquivalent,
    requiredModifiers: Modifiers = []
  ) {
    self.key = key
    self.requiredModifiers = requiredModifiers
  }
}

public enum BindingScope: Sendable, Hashable {
  /// Applies regardless of current tool
  case global
  case toolSpecific(CanvasToolKind)
}

/// ```
/// // Somewhere central (App/Scene/Canvas coordinator):
/// let toolController = ToolController()
/// let bindings: [ToolBinding] = defaultBindings() // build from registry + /// globals
///
/// func keyDown(_ key: KeyEquivalent, modifiers: Modifiers) {
///   // filter applicable bindings for this context
///   toolController.handleKeyDown(key, modifiers: modifiers)
/// }
///
/// func keyUp(_ key: KeyEquivalent) {
///   toolController.handleKeyUp(key)
/// }
///
/// // When you need an operation:
/// let op = CanvasOperation(
///   effectiveTool: toolController.effectiveTool,
///   isSpringLoaded: toolController.isSpringLoaded,
///   state: interactionState,
///   modifiers: currentModifiers
/// )
/// ```

///
/// Lock during gesture: Prevent tool changes while dragging (policy) to avoid jarring transitions.
public struct ToolPolicies: Sendable {
  public let lockUntilPointerUp: Bool  // prevent tool changes mid-drag
  public let releaseEndsOperation: Bool  // if spring key released mid-drag, end at next up
  public let allowGlobalOverrides: Bool  // opt-out of global bindings for this tool
  public let precisionModifier: Modifiers?  // e.g., Control slows zoom/pan
}

/// What modifier or held key activates a behaviour
enum ToolTrigger: Equatable, Sendable {
  case modifierKey(Modifiers)
  case heldKey(KeyEquivalent)
}

/// A declared secondary behaviour for a tool — currently only spring-loading
struct ToolBehaviour: Equatable, Sendable {
  let trigger: ToolTrigger

  /// The tool to temporarily switch to while the trigger is active
  let springLoadTarget: CanvasTool

  /// Human-readable description of the behaviour, useful for tooltips
  let description: String
}
