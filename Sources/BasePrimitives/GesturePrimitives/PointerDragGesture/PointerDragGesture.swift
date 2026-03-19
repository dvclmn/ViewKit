//
//  DragGesture.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 19/3/2026.
//

import SwiftUI

struct PointerDrag: Gesture {
  
  @Bindable var store: DragHandler
//  let behaviour: DragBehavior
//  let minDistance: CGFloat
//  let coordinateSpace: CoordinateSpace
//  @Binding var isGesturing: Bool
//  @Binding var dragState: DragGestureState
//  @Binding var internalRect: CGRect?
  
  var body: some Gesture {
    DragGesture(
      minimumDistance: store.minimumDragDistance,
      coordinateSpace: store.coordinateSpace
    )
    .onChanged { value in
      let isGestureStart = !store.isGesturing
      
      if isGestureStart {
        store.isGesturing = true
        
        /// Anchor once per drag. Marquee uses the gesture start location;
        /// continuous uses the current internal offset as the baseline.
        store.dragState.begin(
          with: store.behaviour.isMarquee
          ? value.startLocation
          : store.internalRect?.size.toCGPoint
        )
      }
      
      let proposed = store.dragState.update(value)
      store.commitRect(proposed?.boundingRect)
      
//      let event = DragGestureEvent(
//        behaviour: behaviour,
//        proposedRect: proposedRect,
//        startLocation: value.startLocation,
//        currentLocation: value.location,
//        translation: value.translation,
//        isGestureStart: isGestureStart
//      )
      
      store.didUpdateEvent(store.internalPayload, isGestureStart ? .began : .changed)
    }
    
    .onEnded { value in
      let proposedRect: CGRect? = store.behaviour.isMarquee ? nil : store.internalRect
      store.commitRect(proposedRect)
      
//      let event = DragGestureEvent(
//        behaviour: behaviour,
//        proposedRect: proposedRect,
//        startLocation: value.startLocation,
//        currentLocation: value.location,
//        translation: value.translation,
//        isGestureStart: false
//      )
      store.didUpdateEvent(event, .ended)
      
      isGesturing = false
      dragState.end()
    }
  }
}
//
//extension PointerDragModifier {
//  package var dragGesture: some Gesture {
//    
//  }
//}
