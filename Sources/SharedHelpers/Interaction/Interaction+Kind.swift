//
//  Interaction+Kind.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 11/1/2026.
//

import Foundation
import EnumMacros

@MetaEnum
enum InteractionKind: Sendable {
  case tap(CGPoint)
  case tapAndDrag(CGRect)
  case tapRanges(Set<Range<Int>>)  // For multi-select
  case gesture(GestureKind)
  case hover(CGPoint)
  case none
  
  //  init(
  //    from pointerPhase: PointerPhase?,
  //    modifiers: Modifiers,
  //    selectedCellsCount: Int
  //  ) {
  //    guard let pointerPhase else {
  //      self = .none
  //      return
  //    }
  //
  //    let kind: InteractionKind
  //    let isDragging = pointerPhase.isDrag
  //    let isTapping = pointerPhase.isTap
  //    switch (isDragging, isTapping, modifiers) {
  //      case (false, true, _): kind = .tap
  //      case (true, false, _): kind = .tapAndDrag
  //      case (false, true, [.shift]) where selectedCellsCount > 0: kind = .rangeBetweenTaps
  //      default: kind = .none
  //    }
  //    self = kind
  //  }
  //  init(from pointerPhase: PointerPhase) {
  //    switch tapDragPhase {
  //      case .drag(type: .marquee, _): .tapAndDrag
  //      case .tap(_): .tap
  //      case .ended: .
  //    }
  //  }
}
