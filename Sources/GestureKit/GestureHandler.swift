//
//  PanGestureHandler.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 9/1/2026.
//

import SwiftUI

import SwiftUI

@Observable
final class GestureHandler {
  var pan: PanState = .initial
  var zoom: ZoomState = .initial
}

extension GestureHandler {
  public func reset(_ kind: GestureKind.Meta) {
    switch kind {
    case .pan:
      pan = .initial
    case .zoom:
      zoom = .initial
    }
//    pan = .zero
  }
  
  public func update(_ kind: GestureKind) {
    switch kind {
    case .pan(let state):
      pan.translate(by: state.offset)
      pan.updatePhase(to: state.phase)
      
    case .zoom(let zoomState):
      zoom = zoomState
    }
//    pan = newOffset
  }
  
//  public mutating func applyPanDelta(_ delta: CGSize) {
//    pan.width += delta.width
//    pan.height += delta.height
//  }
}



//public struct PanHandler {
//  public var pan: CGSize = .zero
//  
//  public init() {}
//}
//
//extension PanHandler {
  
  
//}


//@Observable
//final class PanGestureHandler {
//  var panState: PanState = .init()
////  var phase: PanPhase = .inactive
//}
//
//extension PanGestureHandler {
//  func translate(by delta: CGSize) {
//    panState.offset.width -= delta.width
//    panState.offset.height -= delta.height
//  }
//}
