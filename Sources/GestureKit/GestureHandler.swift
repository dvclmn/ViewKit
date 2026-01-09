//
//  PanGestureHandler.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 9/1/2026.
//

import SwiftUI

@Observable
final class GestureHandler {
  var pan: PanState = .initial
  var zoom: ZoomState = .initial
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
