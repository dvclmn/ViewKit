//
//  ToolBehaviour.swift
//  DrawString
//
//  Created by Dave Coleman on 10/3/2026.
//

//import BasePrimitives
import SwiftUI

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
