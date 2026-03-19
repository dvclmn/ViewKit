//
//  DragHandler.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 19/3/2026.
//

import SwiftUI

@Observable
final class DragHandler {
  var dragState: DragGestureState
  var internalPayload: PointerDragPayload?
  
  /// Legacy, not sure if still needed
  var internalRect: CGRect?
  
  var isGesturing: Bool = false
  let writesBackToBinding: Bool
  let coordinateSpace: CoordinateSpace
  let minimumDragDistance: CGFloat
  var didUpdateEvent: DragEventUpdate = { _, _ in }
  
  init(
    dragState: DragGestureState,
    internalPayload: PointerDragPayload?,
    writesBackToBinding: Bool,
    coordinateSpace: CoordinateSpace,
    minimumDragDistance: CGFloat
//    internalRect: CGRect?
  ) {
    self.dragState = dragState
    self.internalPayload = internalPayload
    self.writesBackToBinding = writesBackToBinding
    self.coordinateSpace = coordinateSpace
    self.minimumDragDistance = minimumDragDistance
//    self.internalRect = internalRect
  }
}

extension DragHandler {
  var behaviour: DragBehavior { dragState.behaviour }
}
