//
//  ToolBehaviour.swift
//  DrawString
//
//  Created by Dave Coleman on 10/3/2026.
//

//import BasePrimitives
import SwiftUI

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

/// - lockUntilPointerUp: If true, once a drag starts, ignore further tool changes until the pointer goes up. This prevents awkward mid-gesture flips.
/// - releaseEndsOperation: If a spring key is released while dragging, choose whether to end the operation immediately or wait for pointer up.
/// - allowGlobalOverrides: Let a tool opt out of global spring keys if needed.
/// - precisionModifier: You can implement “precision mode” (commonly Control/Command) that slows movement or scales deltas.
/// You can attach these policies to Canvas​Tool or to Tool​Binding if different bindings of the same tool need different behavior. Typically they live on the tool.
///
/// Lock during gesture: Prevent tool changes while dragging (policy) to avoid jarring transitions.
public struct ToolPolicies: Sendable {
  public let lockUntilPointerUp: Bool        // prevent tool changes mid-drag
  public let releaseEndsOperation: Bool      // if spring key released mid-drag, end at next up
  public let allowGlobalOverrides: Bool      // opt-out of global bindings for this tool
  public let precisionModifier: Modifiers?   // e.g., Control slows zoom/pan
}

public struct KeyBinding: Hashable, Sendable {
  public let key: KeyEquivalent
  public let requiredModifiers: Modifiers  // your existing type
}

/// Sticky vs toggle: Some tools are pressed once to switch; some are toggles (press to engage, press again to return). Modeled via Activation​Mode.
public enum ActivationMode: Sendable {
  case hold  // spring-load while held
  case toggle  // press to toggle tool; press again to return
  case sticky  // press to switch tool; remains active until changed
}

public enum BindingScope: Sendable, Hashable {
  case global  // applies regardless of current tool
  case toolSpecific(CanvasToolKind)
}

/// • Precision modifier: Holding Control/Command slows pan/zoom rates or constrains angles/snap.
///  Tool palettes/cycling: Press and hold a key to show a palette (submodes), release to commit selection. You can model this as a temporary overlay that changes the base tool.
public struct ToolKeyBinding: Hashable, Sendable {
  public let scope: BindingScope
  public let binding: KeyBinding
  public let target: CanvasToolKind
  public let mode: ActivationMode
  public let priority: Int  // higher wins if multiple match
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

//import BasePrimitives
//import SwiftUI

/// What modifier or held key activates a behaviour
//enum ToolTrigger: Equatable, Sendable {
//  case modifierKey(Modifiers)
//  case heldKey(KeyEquivalent)
//
//}
//
///// A declared secondary behaviour for a tool — currently only spring-loading
//struct ToolBehaviour: Sendable {
//
//  let trigger: ToolTrigger
//
//  /// The tool to temporarily switch to while the trigger is active
//  let springLoadTarget: Tool
//
//  /// Human-readable description of the behaviour, useful for tooltips
//  let description: String
//}
