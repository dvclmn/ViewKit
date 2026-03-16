//
//  CanvasTool.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 12/3/2026.
//

import SwiftUI

/// A canvas tool's identity and visual metadata.
///
/// Keyboard shortcuts are intentionally *not* stored here — they belong
/// in `ToolBinding`, which is the single source of truth for input mapping.
/// This keeps `CanvasTool` focused on "what is this tool?" rather than
/// "how do I activate it?".
public struct CanvasTool: Sendable, Identifiable, Hashable {
  public let kind: CanvasToolKind
  public var id: CanvasToolKind { kind }

  public let name: String
  public let icon: String
//  public let dragBehavior: DragBehavior

  public init(
    kind: CanvasToolKind,
    name: String,
    icon: String,
//    dragBehavior: DragBehavior = .none
  ) {
    self.kind = kind
    self.name = name
    self.icon = icon
//    self.dragBehavior = dragBehavior
  }
}
