//
//  SelectTool.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 12/3/2026.
//

import SwiftUI

// MARK: - Select Tool

/// The default selection tool. Pointer drag produces a marquee rectangle;
/// taps register tap locations.
public struct SelectTool: CanvasTool {
  public let kind: CanvasToolKind = .select
  public let name = "Select"
  public let icon = "cursorarrow"
  public let pointerStyle: PointerStyleCompatible = .default

  public var inputPolicy: CanvasInputPolicy {
    .init(dragBehaviour: .marquee)
  }

  public init() {}

  public func resolvePointerStyle(context: ToolPointerContext) -> PointerStyleCompatible {
    .default
  }

  public func resolvePointerInteraction(
    _ interaction: Interaction,
    currentTransform: TransformState
  ) -> ToolResolution {
    switch interaction.source {
      case .pointerTapGesture(_, let location):
        return .intent(.updatePointerTap(location))

      case .pointerDragGesture(let from, let current):
        let rect = Rect<ScreenSpace>(from: from, to: current)
        return .intent(.updatePointerDrag(rect))

      default:
        return .none
    }
  }
}
