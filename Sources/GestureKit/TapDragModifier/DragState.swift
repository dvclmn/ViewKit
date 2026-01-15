//
//  DragState.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 14/1/2026.
//

import CoreTools
import SwiftUI

@Observable
final class DragState {
//  @Binding var offset: CGSize
  var behaviour: DragBehavior
  var phase: DragPhase
  
  init(
//    offset: CGSize,
    behaviour: DragBehavior,
    phase: DragPhase
  ) {
//    self.offset = offset
    self.behaviour = behaviour
    self.phase = phase
  }
}

extension DragState {
  init(behavior: DragBehavior) {
    
  }
//  static func initial(for behavior: DragBehavior, offset: CGSize) -> DragState {
//    switch behavior {
//      case .marquee:
//        DragState(behaviour: behavior, phase: .)
////      case .marquee: .marquee(.idle)
////      case .cumulative(_, let axes, _): .cumulative(.idle(controller: .init(axes: axes, strategy: .external)))
//    }
//  }
}
extension DragState {

  mutating func handleDragChange(
    _ value: DragGesture.Value,
    behavior: DragBehavior
  ) {
    switch (self, behavior) {

      case (.marquee(.idle), .marquee(let onUpdate)):
        let origin = value.startLocation
        let rect = value.toRect(from: origin, end: .standard)
        onUpdate(.drag(rect, .changed))
        self = .marquee(.dragging(origin: origin))

      case (.marquee(.dragging(let origin)), .marquee(let onUpdate)):
        let rect = value.toRect(from: origin, end: .standard)
        onUpdate(.drag(rect, .changed))

      case (.cumulative(.idle(var controller)), .cumulative(let offset, _, let onDragging)):
        controller.begin(with: offset.wrappedValue)
        offset.wrappedValue = controller.update(translation: value.translation)
        onDragging(true)
        self = .cumulative(.dragging(controller: controller))

      case (.cumulative(.dragging(var controller)), .cumulative(let offset, _, _)):
        offset.wrappedValue = controller.update(translation: value.translation)
        self = .cumulative(.dragging(controller: controller))

      default: assertionFailure("Invalid drag transition")
    }
  }

  mutating func handleDragEnd(behavior: DragBehavior) {
    switch (self, behavior) {
      case (.marquee(.dragging), .marquee(let onUpdate)):
        onUpdate(nil)
        self = .marquee(.idle)

      case (.cumulative(.dragging(var controller)), .cumulative(_, _, let onDragging)):
        controller.end()
        onDragging(false)
        self = .cumulative(.idle(controller: controller))

      default: break
    }
  }


}

//enum DragState {
//  case marquee(origin: CGPoint?)
//  case cumulative(controller: CumulativeDragController)
//
//  mutating func handleDragChange(_ value: DragGesture.Value, behavior: DragBehavior) {
//    switch (self, behavior) {
//      case (.marquee(let origin), .marquee(let onUpdate)):
//        let origin = origin ?? value.startLocation
//        self = .marquee(origin: origin)
//        let rect = value.toRect(from: origin, end: .standard)
//        onUpdate(.drag(rect, .changed))
//
//      case (.cumulative(var controller), .cumulative(let offset, _, let onDragging)):
//        if controller.anchor == nil {
//          controller.begin(with: offset.wrappedValue)
//        }
//        offset.wrappedValue = controller.update(translation: value.translation)
//        self = .cumulative(controller: controller)
//        onDragging(true)
//
//      default:
//        break
//    }
//  }
//

//}
