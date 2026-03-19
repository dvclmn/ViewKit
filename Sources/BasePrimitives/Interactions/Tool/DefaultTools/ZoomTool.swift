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
      case .pointerDragGesture(let payload):
        switch payload {
          case .delta(let size, _):
            var factor = ZoomComputation.factorFromDelta(
              size.cgSize,
              weights: .upRight,
              sensitivity: 200
            )
            // Hold Option to invert the zoom direction during drag, mirroring tap behavior
            if interaction.modifiers.contains(.option) {
              factor = 1 / max(factor, 0.0001)
            }
            var new = currentTransform
            new.scale *= factor
            return .intent(.mutateTransform(new))

          case .rect(let from, let current):
            let fromPoint = from.cgPoint
            let toPoint = current.cgPoint
            let factor = ZoomComputation.factorFromPoints(
              from: fromPoint,
              to: toPoint,
              weights: .upRight,
              sensitivity: 200
            )
            var new = currentTransform
            new.scale *= factor
            return .intent(.mutateTransform(new))

        }
      //      case .pointerDragGesture(let from, let current):

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
