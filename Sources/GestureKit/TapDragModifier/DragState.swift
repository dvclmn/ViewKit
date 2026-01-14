//
//  DragState.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 14/1/2026.
//

import CoreTools
import SwiftUI

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

      default:
        assertionFailure("Invalid drag transition")
    }
  }
  //  mutating func handleDragChange(
  //    _ value: DragGesture.Value,
  //    behavior: DragBehavior
  //  ) {
  //    switch (self, behavior) {
  //
  //      case (.marquee(var state), .marquee(let onUpdate)):
  //        state.update(with: value, onUpdate: onUpdate)
  //        self = .marquee(state)
  //
  //      case (.cumulative(var state), .cumulative(let offset, _, let onDragging)):
  //        state.update(
  //          translation: value.translation,
  //          offset: offset,
  //          onDragging: onDragging
  //        )
  //        self = .cumulative(state)
  //
  //      default:
  //        assertionFailure("Mismatched DragState and DragBehavior")
  //    }
  //  }

  //  mutating func handleDragEnd(behavior: DragBehavior) {
  //    switch (self, behavior) {
  //
  //      case (.marquee(var state), .marquee(let onUpdate)):
  //        state.end(onUpdate: onUpdate)
  //        self = .marquee(state)
  //
  //      case (.cumulative(var state), .cumulative(_, _, let onDragging)):
  //        state.end(onDragging: onDragging)
  //        self = .cumulative(state)
  //
  //      default:
  //        assertionFailure("Mismatched DragState and DragBehavior")
  //    }
  //  }

  mutating func handleDragEnd(behavior: DragBehavior) {
    switch (self, behavior) {

      case (.marquee(.dragging), .marquee(let onUpdate)):
        onUpdate(nil)
        self = .marquee(.idle)

      case (.cumulative(.dragging(var controller)), .cumulative(_, _, let onDragging)):
        controller.end()
        onDragging(false)
        self = .cumulative(.idle(controller: controller))

      default:
        break
    }
  }

  //  mutating func handleDragEnd(behavior: DragBehavior) {
  //    switch (self, behavior) {
  //      case (.marquee, .marquee(let onUpdate)):
  //        onUpdate(nil)
  //        self = .marquee(origin: nil)
  //
  //      case (.cumulative(var controller), .cumulative(_, _, let onDragging)):
  //        controller.end()
  //        self = .cumulative(controller: controller)
  //        onDragging(false)
  //
  //      default:
  //        break
  //    }
  //  }

  static func initial(for behavior: DragBehavior) -> DragState {
    switch behavior {
      case .marquee: .marquee(.idle)

      //        return .marquee(.dragging(origin: .zero))
      //        return .marquee(MarqueeDragState(origin: nil))

      case .cumulative(_, let axes, _): .cumulative(.idle(controller: .init(axes: axes, strategy: .external)))
    //        return .cumulative(
    //          CumulativeDragState(
    //            controller: .init(axes: axes, strategy: .external)
    //          )
    //        )

    }
  }
}

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

struct CumulativeDragState {
  var controller: CumulativeDragController
}

extension CumulativeDragState {

  mutating func update(
    translation: CGSize,
    offset: Binding<CGSize>,
    onDragging: (Bool) -> Void
  ) {
    if controller.anchor == nil {
      controller.begin(with: offset.wrappedValue)
    }

    offset.wrappedValue = controller.update(translation: translation)
    onDragging(true)
  }

  mutating func end(onDragging: (Bool) -> Void) {
    controller.end()
    onDragging(false)
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
