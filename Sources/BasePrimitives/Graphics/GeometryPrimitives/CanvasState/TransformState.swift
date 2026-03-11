//
//  CanvasTransformState.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 1/3/2026.
//

import SwiftUI

/// Value-semantic snapshot of canvas transform interactions.
public struct TransformState: Sendable, Equatable {
  public var panState: PanState = .initial
  public var zoomState: ZoomState = .initial
  public var rotationState: RotateState = .initial
  public var latchedZoomFocusGlobal: CGPoint?
}

extension TransformState: ActivityDescribing {

  public var zoom: Double { zoomState.value }
  public var pan: CGSize { panState.value }
  public var rotation: Angle { rotationState.rotation }

  public static var initial: Self { .init() }

  public var activityDescription: String {
    let panStatus = activityLabel(panState.isActive)
    let zoomStatus = activityLabel(zoomState.isActive)
    let rotationStatus = activityLabel(rotationState.isActive)

    let panText = "Pan (\(panStatus))"
    let zoomText = "Zoom (\(zoomStatus))"
    let rotationText = "Rotation (\(rotationStatus))"

    return [panText, zoomText, rotationText].joined(separator: ", ")
    //    var parts = [panText, zoomText, rotationText]

    //    if let focus = latchedZoomFocusGlobal {
    //      let focusText = String(format: "Focus: (%.1f, %.1f)", focus.x, focus.y)
    //      parts.append(focusText)
    //    }

    //    return parts.joined(separator: ", ")
  }
}
