//
//  CanvasTool.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 12/3/2026.
//

import SwiftUI

//  public var onActivate: @Sendable (ToolContext) -> Void
//  public var onDeactivate: @Sendable (ToolContext) -> Void
//  public var handleGesture: @Sendable (GestureEvent, ToolContext) -> Void

public struct CanvasTool: Sendable, Identifiable, Hashable {
  public let id: UUID
  public let name: String
  public let icon: String
  public let shortcutKey: KeyEquivalent?

  /// ```
  /// public static let zoom = CanvasTool(
  ///   name: "Zoom",
  ///   icon: "magnifyingglass",
  ///   shortcutKey: "z",
  ///   behaviours: [
  ///     ToolBehaviour(
  ///       trigger: .modifierKey(.command),
  ///       springLoadTarget: .select,  // see note below on decoupling this
  ///       description: "Hold Command to temporarily select"
  ///     )
  ///   ],
  ///   dragBehavior: .none
  /// )
  /// ```
  //  public let behaviours: [ToolBehaviour]

  public let dragBehavior: DragBehavior

  public init(
    id: UUID = UUID(),
    name: String,
    icon: String,
    shortcutKey: KeyEquivalent? = nil,
    dragBehavior: DragBehavior,
  ) {
    self.id = id
    self.name = name
    self.icon = icon
    self.shortcutKey = shortcutKey
    self.dragBehavior = dragBehavior
  }
}

//public struct CanvasToolRegistry {
//  private var toolsByID: [String: CanvasTool] = [:]
//
//  public init(_ tools: [CanvasTool]) {
//    tools.forEach { toolsByID[$0.id] = $0 }
//  }
//
//  public func tool(id: String) -> CanvasTool? { toolsByID[id] }
//  public var allTools: [CanvasTool] { Array(toolsByID.values) }
//}

//public struct ToolBehaviour: Sendable, Hashable {
//
//  public enum Trigger: Sendable, Hashable {
//    case modifierKey(Modifiers)
//  }
//  public let trigger: Trigger
//  public let springLoadTargetID: String?
//  public let description: String
//}
