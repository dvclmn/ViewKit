//
//  PointerPhase.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 14/8/2025.
//

import CoreTools
import Foundation

/// Note: Could consider creating a type to encapsulate
/// the `CGPoint`/`CGRect` overlaps, for Taps/Drags.
///
/// If modifiers are present, then we may be dealing with
/// e.g. a Selection (range between taps) kind.
/// Could replace DrawString's `InteractionKind`
///
@CaseDetection
@AssociatedValues
@MetaEnum
public enum PointerPhase: Equatable, Sendable {
  case drag(rect: CGRect)
  case tap(location: CGPoint, modifiers: Modifiers?)
  case hover(location: CGPoint)
  case ended
  case inactive
}

public struct PointerInteraction: Sendable {
  let phase: PointerPhase
  let modifiers: Modifiers?
  
  public init(
    phase: PointerPhase,
    modifiers: Modifiers? = nil
  ) {
    self.phase = phase
    self.modifiers = modifiers
  }
}

struct Thing {
  let phase: Phase
//  let action: Action
  let interaction: Interaction
  let modifiers: Modifiers?
}


//extension PointerInteraction.Options {
//  init(
//    from pointerPhase: PointerPhase,
//    modifiers: Modifiers,
//    selectionCount: Int
//  ) {
//
////    guard let pointerPhase else {
////      self = []
////      return
////    }
//
////    let kind: InteractionKind
//    let isDragging = pointerPhase.isDrag
//    let isTapping = pointerPhase.isTap
//
//    switch (isDragging, isTapping, modifiers) {
//      case (false, true, _): self = .tap
//      case (true, false, _): self = .rangeSelect
//      case (false, true, [.shift]) where selectionCount > 0: kind = .rangeBetweenTaps
//      default: kind = .none
//    }
//    self = kind
//  }
//}
