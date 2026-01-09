//
//  PanGestureHandler.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 9/1/2026.
//

import SwiftUI

@Observable
public final class GestureHandler {
  var pan: PanState
  var zoom: ZoomState
  
  let zoomRange: ClosedRange<CGFloat>
  
  public init(
    pan: PanState  = .initial,
    zoom: ZoomState = .initial,
    zoomRange: ClosedRange<CGFloat>  = 0.1...8
  ) {
    self.pan = pan
    self.zoom = zoom
    self.zoomRange = zoomRange
  }
}

extension GestureHandler {

  public func update(_ kind: GestureKind) {
    switch kind {
      case .pan(let state):

        pan = pan.translated(by: state.offset)
          .withPhase(state.phase)

      case .zoom(let state):
        zoom = state
    }
  }

  public func reset(_ kind: GestureKind.Meta) {
    switch kind {
      case .pan:
        pan = .initial
      case .zoom:
        zoom = .initial
    }
  }

  //  public func update(_ kind: GestureKind) {
  //    switch kind {
  //      case .pan(let state):
  //        pan.translate(by: state.offset)
  //        pan.updatePhase(to: state.phase)
  //
  //      case .zoom(let zoomState):
  //        zoom = zoomState
  //    }
  //  }
}
