//
//  CanvasTool.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 12/3/2026.
//

import SwiftUI

// MARK: - CanvasToolKind

/// An extensible tool identity type — same pattern as `Notification.Name`.
///
/// Define new kinds by extending this type in any module:
/// ```swift
/// extension CanvasToolKind {
///   public static let brush = Self(rawValue: "brush")
/// }
/// ```
public struct CanvasToolKind: RawRepresentable, Hashable, Sendable {
  public let rawValue: String
  public init(rawValue: String) { self.rawValue = rawValue }
}

extension CanvasToolKind {
  public static let select = Self(rawValue: "select")
  public static let pan    = Self(rawValue: "pan")
  public static let zoom   = Self(rawValue: "zoom")
  public static let text   = Self(rawValue: "text")
}

// MARK: - CanvasTool

public struct CanvasTool: Sendable, Identifiable, Hashable {
  /// Stable, switchable identity.
  public let kind: CanvasToolKind

  /// `Identifiable` conformance — backed by `kind` so tools with the same
  /// role are considered the same item in SwiftUI lists.
  public var id: CanvasToolKind { kind }

  public let name: String
  public let icon: String
  public let shortcutKey: KeyEquivalent?
  public let dragBehavior: DragBehavior

  public init(
    kind: CanvasToolKind,
    name: String,
    icon: String,
    shortcutKey: KeyEquivalent? = nil,
    dragBehavior: DragBehavior
  ) {
    self.kind = kind
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
