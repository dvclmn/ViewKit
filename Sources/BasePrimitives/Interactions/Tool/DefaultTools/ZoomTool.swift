//
//  ZoomTool.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 12/3/2026.
//

import SwiftUI

// MARK: - Zoom Tool

/// When selected, pointer click-drag zooms (vertical axis).
/// Tap to zoom in, Option+tap to zoom out.
public struct ZoomTool: CanvasTool {
  public let kind: CanvasToolKind = .zoom
  public let name = "Zoom"
  public let icon = "magnifyingglass"
  public let pointerStyle: PointerStyleCompatible = .zoomIn

  public var inputPolicy: CanvasInputPolicy {
    .init(dragBehaviour: .continuous(axes: .vertical))
  }

  public init() {}

  public func resolvePointerInteraction(
    _ interaction: Interaction,
    currentTransform: TransformState
  ) -> ToolResolution {
    switch interaction.source {
      case .pointerDragGesture(let from, let current):
        let verticalDelta = current.cgPoint.y - from.cgPoint.y
        let zoomFactor = 1.0 + (verticalDelta / 200.0)
        var new = currentTransform
        new.scale *= zoomFactor
        return .intent(.mutateTransform(new))

      case .pointerTapGesture(_, _):
        let step: CGFloat = interaction.modifiers.contains(.option) ? 0.8 : 1.25
        var new = currentTransform
        new.scale *= step
        return .intent(.mutateTransform(new))

      default:
        return .none
    }
  }

  public func resolvePointerStyle(
    context: ToolPointerContext
  ) -> PointerStyleCompatible {
    context.modifiers.contains(.option) ? .zoomOut : .zoomIn
  }
}
