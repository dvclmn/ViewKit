//
//  PanGestureHandler.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 9/1/2026.
//

import BasePrimitives
import SwiftUI

public struct GestureHandler {
  var pan: PanState
  var zoom: ZoomState
  var rotate: RotateState

//  public var interactions: InteractionHandler = .init()

  public let zoomRange: ClosedRange<CGFloat>

  public init(
    pan: PanState = .initial,
    zoom: ZoomState = .initial,
    rotate: RotateState = .initial,
    zoomRange: ClosedRange<CGFloat> = 0.1...8
  ) {
    self.pan = pan
    self.zoom = zoom
    self.rotate = rotate
    self.zoomRange = zoomRange
  }
}

extension GestureHandler {

  /// Clamped
  public var zoomLevel: CGFloat { zoom.clamped(in: zoomRange).value }
  public var zoomPercent: CGFloat { zoom.percentage }
  public var panOffset: CGSize { pan.value }
  public var rotation: Angle { rotate.value }

  public mutating func update(
    _ kind: GestureKind,
    geometry: CanvasGeometry
  ) {
    switch kind {
      case .pan(let state):
        pan = pan.translated(by: state.offset)
          .withPhase(state.phase)

      case .zoom(let adjustment):
        zoom = adjustment.resolve(
          current: zoom,
          artwork: geometry.canvasSize,
          viewport: geometry.viewportSize
        )

      case .rotate(let state):
        rotate = state

      default: break
    }

    /// Update current interaction
    updateIfChanged(&interactions.interaction, to: kind.interactionType)
  }

  public mutating func reset(_ kind: GestureKind.Meta) {
    switch kind {
      case .pan: pan = .initial
      case .zoom: zoom = .initial
      case .rotate: rotate = .initial
      default: break
    }
  }
}
