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
    .init(dragBehaviour: .continuous)
  }

  public init() {}

  public func resolvePointerInteraction(
    context: InteractionContext,
//    _ interaction: Interaction,
    currentTransform: TransformState
  ) -> ToolResolution {
    switch context.source {
      case .pointerDragGesture(let payload):
        
        switch payload {
          case .delta(let delta, _):
            var new = currentTransform
            new.translation += delta
            
            return .intent(.mutateTransform(new))

          case .rect(let from, let current):
            print("Not sure if this is right")
            return .none
        }
//        let delta = current - from

      default:
        return .none
    }
  }

  public func resolvePointerStyle(
    context: InteractionContext
  ) -> PointerStyleCompatible {
    context.isPointerDragging ? .grabActive : .grabIdle
  }
}
