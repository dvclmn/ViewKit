//
//  CanvasTool.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 12/3/2026.
//

import SwiftUI

public struct CanvasTool: Sendable, Identifiable, Hashable {
  /// Stable, switchable identity.
  public let kind: CanvasToolKind
  public var id: CanvasToolKind { kind }

  public let name: String
  public let icon: String

  /// Can be pressed once to activate the Tool, or held to 'spring load' it.
  /// This allows the tool to be active only while it's key is held,
  /// and once released the previously active tool is restored.
  public let shortcutKey: KeyEquivalent?

  /// Some tools support an additional key for spring loading, over and above
  /// their `shortcutKey`. E.g. Pan with the Space key
  public let springLoadKey: KeyEquivalent?
  public let dragBehavior: DragBehavior

  public init(
    kind: CanvasToolKind,
    name: String,
    icon: String,
    shortcutKey: KeyEquivalent?,
    springLoadKey: KeyEquivalent? = nil,
    dragBehavior: DragBehavior = .none
  ) {
    self.kind = kind
    self.name = name
    self.icon = icon
    self.shortcutKey = shortcutKey
    self.springLoadKey = springLoadKey
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
