//
//  PanTool.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 12/3/2026.
//

import SwiftUI

// MARK: - Pan Tool

/// When selected, pointer click-drag pans the canvas.
public struct PanTool: CanvasTool {
  public let kind: CanvasToolKind = .pan
  public let name = "Pan"
  public let icon = "hand.raised"
  public let pointerStyle: PointerStyleCompatible = .grabIdle

  public var inputPolicy: CanvasInputPolicy {
    .init(pointerDragPanEnabled: true, dragBehaviour: .continuous)
  }

  public init() {}

  public func resolvePointerInteraction(
    _ interaction: Interaction,
    currentTransform: TransformState
  ) -> ToolResolution {
    switch interaction.source {
      case .pointerDragGesture(let delta, _):
//        let delta = current - from
        var new = currentTransform
        new.translation += delta
        
        return .intent(.mutateTransform(new))

      default:
        return .none
    }
  }

  public func resolvePointerStyle(
    context: ToolPointerContext
  ) -> PointerStyleCompatible {
    context.isPointerDragging ? .grabActive : .grabIdle
  }
}
