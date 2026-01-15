//
//  DragState.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 14/1/2026.
//

import CoreTools
import SwiftUI

struct DragGestureState {

  let behaviour: DragBehavior
  /// Common to both behaviours
  //  var rect: CGRect

  /// The start location of the offset, captured at drag start
  private(set) var anchor: CGPoint?
  //  private(set) var anchor: CGPoint?

  /// The last computed offset value
  private var lastComputedValue: CGSize?

  /// Probably ignored for marquee?
  //  let axes: GridAxis.Set

  /// Carries the logic unique to each behaviour
  //  let phase: DragPhase

  /// Notify the modifier whether a drag is occuring
  //  var isDragging: Bool
  //  let isDragging: DragUpdate

  init(
    _ behaviour: DragBehavior,
    //        axes: GridAxis.Set
  ) {
    self.behaviour = behaviour
    //    switch behaviour {
    //      case .marquee: self.axes = .all
    //      case .continuous(let axes): self.axes = axes
    //    }
    //    self.behaviour = DragBehavior.Meta(behaviour)
    //    self.axes = behaviour.continuousValue ?? .all
  }
}

//extension DragState {
//
//  static func initial(
//    behaviour: DragBehavior,
//    axes: GridAxis.Set,
////    for behaviour: DragBehavior,
////    offset: CGSize
//  ) -> DragState {
//    DragState(behaviour: behaviour, axes: axes)
////    self.behavioud =
////    switch behavior {
////      case .marquee:
////      case .:
////        DragState(beha.vio., phase: .)
//        //      case .marquee: .marquee(.idle)
//        //      case .cumulative(_, let axes, _): .cumulative(.idle(controller: .init(axes: axes, strategy: .external)))
////    }
//  }
//}

extension DragGestureState {

    var value: CGRect { lastComputedValue?.toCGRectZeroOrigin ?? .zero }

  /// For this, marquee wants the `Gesture.Value` start location
  /// Continuous wants the latest `Binding<CGSize>` offset value.
  mutating func begin(with currentExternalValue: CGPoint? = nil) {
    guard let val = currentExternalValue else { return }
    anchor = val
  }

  /// It's important for marquee to be able to expres `nil`
  mutating func update(
    _ gestureValue: DragGesture.Value,
  ) -> CGRect? {
    
    switch behaviour {
      case .marquee:
        guard let anchor else { return nil }
        let newRect = gestureValue.toRect(from: anchor, end: .standard)
        lastComputedValue = newRect.size
        return newRect

      case .continuous:
//        print("Handling update for `.continuous` Drag gesture at \(Date.debug)")
        guard let anchor else {
          print("No anchor found, returning current value: \(value.displayString)")
          return value
        }
        
//        print("\(#file)/\(#function) Did find anchor: \(anchor.displayString) at \(Date.debug)")
        
        let base = anchor.toCGSize
        let size = applyAxis(
          behaviour.axes,
          base: base,
          translation: gestureValue.translation
        )

        lastComputedValue = size
        return CGRect(origin: .zero, size: size)
    }


  }

  mutating func end() {
//  mutating func end() -> CGRect? {
    
    anchor = nil
//    switch DragBehavior.Meta(behaviour) {
//      case .marquee:
//        return nil
//        
//      case .continuous:
////        return lastComputedValue.
//    }
  }

  private func applyAxis(
    _ axes: GridAxis.Set,
    base: CGSize,
    translation: CGSize
  ) -> CGSize {
    switch axes {
      case .horizontal:
        CGSize(
          width: base.width + translation.width,
          height: base.height
        )
      case .vertical:
        CGSize(
          width: base.width,
          height: base.height + translation.height
        )
      default:
        CGSize(
          width: base.width + translation.width,
          height: base.height + translation.height
        )
    }
  }
}

extension DragGestureState {

  //  mutating func handleDragChange(
  //    _ value: DragGesture.Value,
  //    behavior: DragBehavior
  //  ) {
  //    switch (phase, behavior) {
  //
  //      case (.marquee(.idle), .marquee(_)):
  //        let origin = value.startLocation
  //        let rect = value.toRect(from: origin, end: .standard)
  //        self.rect = rect
  //        self.isDragging(true)
  //
  //      case (.marquee(.dragging(let origin)), .marquee(let onUpdate)):
  //        let rect = value.toRect(from: origin, end: .standard)
  //        onUpdate(.drag(rect, .changed))
  //
  //      case (.cumulative(.idle(var controller)), .cumulative(let offset, _, let onDragging)):
  //        controller.begin(with: offset.wrappedValue)
  //        offset.wrappedValue = controller.update(translation: value.translation)
  //        onDragging(true)
  //        self = .cumulative(.dragging(controller: controller))
  //
  //      case (.cumulative(.dragging(var controller)), .cumulative(let offset, _, _)):
  //        offset.wrappedValue = controller.update(translation: value.translation)
  //        self = .cumulative(.dragging(controller: controller))
  //
  //      default: assertionFailure("Invalid drag transition")
  //    }
  //  }
  //
  //  mutating func handleDragEnd(behavior: DragBehavior) {
  //    switch (self, behavior) {
  //      case (.marquee(.dragging), .marquee(let onUpdate)):
  //        onUpdate(nil)
  //        self = .marquee(.idle)
  //
  //      case (.cumulative(.dragging(var controller)), .cumulative(_, _, let onDragging)):
  //        controller.end()
  //        onDragging(false)
  //        self = .cumulative(.idle(controller: controller))
  //
  //      default: break
  //    }
  //  }

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
