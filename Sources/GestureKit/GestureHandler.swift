//
//  PanGestureHandler.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 9/1/2026.
//

import CoreTools
import SwiftUI

public struct GestureHandler {

  /// Each of these only hold a single value, but helps having
  /// the gesture=specific methods separated out
  var pan: PanState
  var zoom: ZoomState
  var rotate: RotateState

  var phase: InteractionPhase = .none
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
    phase: InteractionPhase,
    geometry: CanvasGeometry
  ) {
    /// Update with new phase
    self.phase = phase

    switch kind {
      case .pan(let value):
        pan = pan.translated(by: value)

      //          .withPhase(state.phase)

      case .zoom(let value):
        let newZoom: CGFloat = value.resolve(
          //          current: zoom,
          artwork: geometry.canvasSize,
          viewport: geometry.viewportSize
        )
        zoom = ZoomState(zoom: newZoom)

      case .rotate(let value):
        rotate = RotateState(rotation: value)

//      default: break
    }

    /// Update current interaction
//    updateIfChanged(&interactions.interaction, to: kind.interactionType)
  }

  public mutating func reset(_ kind: GestureKind.Meta) {
    switch kind {
      case .pan: pan = .initial
      case .zoom: zoom = .initial
      case .rotate: rotate = .initial
//      default: break
    }
  }
}
