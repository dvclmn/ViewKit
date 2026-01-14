//
//  DragState.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 14/1/2026.
//

import CoreTools
import SwiftUI

enum DragState {
  case marquee(origin: CGPoint?)
  case cumulative(controller: CumulativeDragController)

  mutating func handleDragChange(_ value: DragGesture.Value, behavior: DragBehavior) {
    switch (self, behavior) {
      case (.marquee(let origin), .marquee(let onUpdate)):
        let origin = origin ?? value.startLocation
        self = .marquee(origin: origin)
        let rect = value.toRect(from: origin, end: .standard)
        onUpdate(.drag(rect, .changed))

      case (.cumulative(var controller), .cumulative(let offset, _, let onDragging)):
        if controller.anchor == nil {
          controller.begin(with: offset.wrappedValue)
        }
        offset.wrappedValue = controller.update(translation: value.translation)
        self = .cumulative(controller: controller)
        onDragging(true)

      default:
        break
    }
  }

  mutating func handleDragEnd(behavior: DragBehavior) {
    switch (self, behavior) {
      case (.marquee, .marquee(let onUpdate)):
        onUpdate(nil)
        self = .marquee(origin: nil)

      case (.cumulative(var controller), .cumulative(_, _, let onDragging)):
        controller.end()
        self = .cumulative(controller: controller)
        onDragging(false)

      default:
        break
    }
  }
}
