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

public struct PanHandler {
  public var pan: CGSize = .zero
  
  public init() {}
}

extension PanHandler {
  
  public mutating func reset() {
    pan = .zero
  }
  
  public mutating func update(_ newOffset: CGSize) {
    pan = newOffset
  }
  
  public mutating func applyPanDelta(_ delta: CGSize) {
    pan.width += delta.width
    pan.height += delta.height
  }
}


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
