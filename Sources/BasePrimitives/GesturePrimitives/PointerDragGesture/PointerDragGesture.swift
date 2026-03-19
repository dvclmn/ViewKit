//
//  DragGesture.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 19/3/2026.
//

import SwiftUI

extension PointerDragModifier {
  package var dragGesture: some Gesture {
    DragGesture(
      minimumDistance: minimumDistance,
      coordinateSpace: coordinateSpace
    )
    .onChanged { value in
      let isGestureStart = !isGesturing
      
      if isGestureStart {
        isGesturing = true
        
        /// Anchor once per drag. Marquee uses the gesture start location;
        /// continuous uses the current internal offset as the baseline.
        dragState.begin(
          with: behaviour.isMarquee
          ? value.startLocation
          : internalRect?.size.toCGPoint
        )
      }
      
      let proposedRect = dragState.update(value)
      commitRect(proposedRect)
      
      let event = DragGestureEvent(
        behaviour: behaviour,
        proposedRect: proposedRect,
        startLocation: value.startLocation,
        currentLocation: value.location,
        translation: value.translation,
        isGestureStart: isGestureStart
      )
      didUpdateEvent(event, isGestureStart ? .began : .changed)
    }
    
    .onEnded { value in
      let proposedRect: CGRect? = behaviour.isMarquee ? nil : internalRect
      commitRect(proposedRect)
      
      let event = DragGestureEvent(
        behaviour: behaviour,
        proposedRect: proposedRect,
        startLocation: value.startLocation,
        currentLocation: value.location,
        translation: value.translation,
        isGestureStart: false
      )
      didUpdateEvent(event, .ended)
      
      isGesturing = false
      dragState.end()
    }
  }
}
