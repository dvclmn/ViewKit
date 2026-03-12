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
  public let shortcutKey: KeyEquivalent

  /// Some tools support an additional key for spring loading, over and above
  /// their `shortcutKey`. E.g. Pan with the Space key
  public let springLoadKey: KeyEquivalent?
  public let dragBehavior: DragBehavior

  public init(
    kind: CanvasToolKind,
    name: String,
    icon: String,
    shortcutKey: KeyEquivalent,
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

//@dynamicMemberLookup
//public struct CanvasToolRegistry {
//  private var toolsByID: [CanvasToolKind: CanvasTool] = [:]
//
//  public init(_ tools: [CanvasTool]) {
//    tools.forEach { toolsByID[$0.id] = $0 }
//  }
//
//  public func tool(id: CanvasToolKind) -> CanvasTool? { toolsByID[id] }
//  public var allTools: [CanvasTool] { Array(toolsByID.values) }
//}
//
//extension CanvasToolRegistry {
//  subscript<T>(dynamicMember keyPath: WritableKeyPath<CanvasTool, T>) -> CanvasTool? {
//    // This keyPath-based dynamic member doesn't have a comparison value,
//    // so it cannot infer a unique tool to return. It is kept only to
//    // satisfy the API surface for now and always returns nil.
//    // Consider using the String-based dynamic member below instead.
//    return nil
//  }
//
//  /// Dynamic member lookup by member name, enabling calls like
//  /// `registry.select` or `registry.pan` to resolve a tool.
//  ///
//  /// Resolution order:
//  /// 1) Match against the `CanvasToolKind` name via `String(describing:)`,
//  ///    case-insensitive.
//  /// 2) Fall back to matching the tool's `name` (spaces removed),
//  ///    case-insensitive.
//  public subscript(dynamicMember member: String) -> CanvasTool? {
//    let needle = member.replacingOccurrences(of: " ", with: "").lowercased()
//
//    // Try matching by kind name first (e.g., ".select" -> "select")
//    if let byKind = toolsByID.first(where: { key, _ in
//      String(describing: key).lowercased() == needle
//    })?.value {
//      return byKind
//    }
//
//    // Fall back to the tool's display name (normalized)
//    return toolsByID.values.first { tool in
//      tool.name.replacingOccurrences(of: " ", with: "").lowercased() == needle
//    }
//  }
//}
