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
}

extension ZoomTool {

  public func resolvePointerStyle(
    context: InteractionContext
  ) -> PointerStyleCompatible {
    context.modifiers.contains(.option) ? .zoomOut : .zoomIn
  }

  public func resolvePointerInteraction(
    context: InteractionContext,
    //    source: InteractionSource,
    //    _ interaction: Interaction,
    currentTransform: TransformState
  ) -> ToolResolution {
    switch context.source {
      case .pointerDragGesture(let payload):
        return handlePointerDrag(
          payload,
          modifiers: context.modifiers,
          //          interaction: interaction,
          transform: currentTransform
        )

      case .pointerTapGesture(_, _):
        let step = context.modifiers.contains(.option) ? 0.8 : 1.25
        var new = currentTransform
        new.scale *= step
        return .canvasAdjustment(.updateTransform(new))

      default:
        return .none
    }
  }

}

extension ZoomTool {
  private func handlePointerDrag(
    _ payload: PointerDragPayload,
    modifiers: Modifiers,
    //    interaction: Interaction,
    transform: TransformState
  ) -> ToolResolution {

    switch payload {

      case .delta(let size, _):
        var factor = ZoomComputation.factorFromDelta(
          size.cgSize,
          weights: .upRight
        )
        /// Hold Option to invert the zoom direction during drag, mirroring tap behavior
        if modifiers.contains(.option) {
          factor = 1 / max(factor, 0.0001)
        }
        var new = transform
        new.scale *= factor
        return .canvasAdjustment(.updateTransform(new))

      case .rect(let from, let current):
        let fromPoint = from.cgPoint
        let toPoint = current.cgPoint
        let factor = ZoomComputation.factorFromPoints(
          from: fromPoint,
          to: toPoint,
          weights: .upRight
        )
        var new = transform
        new.scale *= factor
        return .canvasAdjustment(.updateTransform(new))

    }
  }
}
