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
    _ kind: InteractionKind,
    phase: InteractionPhase,
    geometry: CanvasGeometry
  ) {
    /// Update with new phase
    self.phase = phase

    switch kind {
      case .gesturePan(let value):
        pan = pan.translated(by: value)

      //          .withPhase(state.phase)

      case .gestureZoom(let value):
        /// Will need to save this in case I somehow route the
        /// zoom action kind that I want
        //        let newZoom: CGFloat = value.resolve(
        //          //          current: zoom,
        //          artwork: geometry.canvasSize,
        //          viewport: geometry.viewportSize
        //        )
        zoom = ZoomState(zoom: value)

      case .gestureRotate(let value):
        rotate = RotateState(rotation: value)

      default:
        assertionFailure("Only handling *gesture* interaction types here")
//        print("")
        break
    //      default: break
    }

    /// Update current interaction
    //    updateIfChanged(&interactions.interaction, to: kind.interactionType)
  }

  public mutating func reset(_ kind: InteractionKind.Meta) {
    switch kind {
      case .gesturePan: pan = .initial
      case .gestureZoom: zoom = .initial
      case .gestureRotate: rotate = .initial
      default:
        assertionFailure("Only handling *gesture* interaction types here")
        break
    //      default: break
    }
  }
}
