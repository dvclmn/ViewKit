//
//  Model+Mode.swift
//  BaseComponents
//
//  Created by Dave Coleman on 9/7/2025.
//

import CoreTools
import SwiftUI

struct Interaction {
  let kind: InteractionKind
  let phase: InteractionPhase
  let modifiers: Modifiers?
}

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

/// Note: I've omitted keyboard here, despite including it earlier,
/// as I need to be able to model the below with a key held, etc.
///
/// I've also removed hover, and this seems like something that
/// should be allowed to just be happening ambiently, at all times?
//public enum Interaction: Sendable, Equatable {
//  case gestureZoom
//  case gesturePan
//  case gestureRotate
//
//  case dragPan
//  case dragSelect
//  case dragResize
//
//  case tap
//  case none
//
//  public var name: String {
//    switch self {
//      case .gestureZoom: "Zoom Gesture"
//      case .gesturePan: "Pan Gesture"
//      case .gestureRotate: "Rotate Gesture"
//      case .dragSelect: "Select Drag"
//      case .dragPan: "Pan Drag"
//      case .dragResize: "Resize Drag"
//      case .tap: "Tap"
//      case .none: "None"
//    }
//  }
//}

public struct InputMethods: OptionSet, Sendable, Hashable {
  public init(rawValue: Int) {
    self.rawValue = rawValue
  }
  public let rawValue: Int

  static public let touchGesture = InputMethods(rawValue: 1 << 0)
  static public let dragGesture = InputMethods(rawValue: 1 << 1)
  static public let tap = InputMethods(rawValue: 1 << 2)
}
