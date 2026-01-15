//
//  MarqueeState.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 14/1/2026.
//

import SwiftUI

struct MarqueeDragState {
  var origin: CGPoint?
}
extension MarqueeDragState {
  
  mutating func update(
    with value: DragGesture.Value,
    onUpdate: MarqueeUpdate
  ) {
    let origin = origin ?? value.startLocation
    self.origin = origin
    
    let rect = value.toRect(from: origin, end: .standard)
    onUpdate(.drag(rect, .changed))
  }
  
  mutating func end(onUpdate: (MarqueeUpdate?) -> Void) {
    onUpdate(nil)
    origin = nil
  }
}
