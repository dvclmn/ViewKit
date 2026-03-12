//
//  CanvasTool.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 12/3/2026.
//

import SwiftUI

//public protocol CanvasTool {
//  var invocation: ToolInvocation { get }
//}
//
//extension CanvasTool {
//  public var invocation: ToolInvocation { .standard }
//}
//
//public struct SelectTool: CanvasTool {
//
//}

public struct CanvasTool: Sendable, Identifiable, Hashable {
  public let id: UUID
//  public let id: String
  public let name: String
  public let icon: String
  public let shortcutKey: KeyEquivalent?
//  public let behaviours: [ToolBehaviour]
  public let dragBehavior: DragBehavior

  // Optional hooks
  //  public var onActivate: @Sendable (ToolContext) -> Void
  //  public var onDeactivate: @Sendable (ToolContext) -> Void
  //  public var handleGesture: @Sendable (GestureEvent, ToolContext) -> Void

  public init(
    id: UUID = UUID(),
    name: String,
    icon: String,
    shortcutKey: KeyEquivalent? = nil,
//    hoverColor: Color? = nil,
//    behaviours: [ToolBehaviour] = [],
    dragBehavior: DragBehavior,
    //    onActivate: @escaping @Sendable (ToolContext) -> Void = { _ in },
    //    onDeactivate: @escaping @Sendable (ToolContext) -> Void = { _ in },
    //    handleGesture: @escaping @Sendable (GestureEvent, ToolContext) -> Void = { _, _ in }
  ) {
    self.id = id
    self.name = name
    self.icon = icon
    self.shortcutKey = shortcutKey
//    self.hoverColor = hoverColor
//    self.behaviours = behaviours
    self.dragBehavior = dragBehavior
    //    self.onActivate = onActivate
    //    self.onDeactivate = onDeactivate
    //    self.handleGesture = handleGesture
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
