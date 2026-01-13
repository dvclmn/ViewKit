//
//  Pointer.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 12/1/2026.
//

import CoreTools
import Foundation

public enum PointerInteraction {
  //  case tap
  //  case drag
  //  case hover
  case tap(CGPoint)
  case drag(CGRect)
  case hover(CGPoint)
}

public struct PointerState {
  /// If a drag is detected, this is the origin
  let start: CGPoint?

  /// Current pointer location. If `start` is `nil`,
  var current: CGPoint?

  var phase: InteractionPhase

  let dragThreshold: CGFloat = 4
}

extension PointerState {
  public static var initial: Self {
    .init(start: .zero, current: .zero, phase: .ended)
  }

  //  public var interactionKind: PointerInteraction? {
  //    switch phase {
  //      case .changed: isDrag ? .drag : nil
  //      case .ended: isDrag ? .drag : .tap
  //      case .stationary: .hover(current)
  ////      default: nil
  //    }
  //  }

  public var translation: CGSize? {
    guard let current, let start else { return nil }
    let result = CGSize(
      width: current.x - start.x,
      height: current.y - start.y
    )
    let isValidDrag = hypot(result.width, result.height) >= dragThreshold
    return isValidDrag ? result : nil
  }

  /// Returns true if the current pointer state indicates that it is of
  /// type Drag; not a Tap, nor a Hover
  public var isDrag: Bool { translation != nil }

  public var dragRect: CGRect? {
    guard let translation, let start else { return nil }
    return CGRect(origin: start, size: translation).standardized
  }
}

//struct PointerStream {
//  var start: CGPoint
//  var current: CGPoint
//  var phase: InteractionPhase
//}

/// For handling Tap, Drag and Hover
//public struct PointerTracking: Sendable {
//  let start: CGPoint
//  var current: CGPoint
//  var phase: InteractionPhase
//
//  let dragThreshold: CGFloat = 4
//}
//
//extension PointerTracking {
//  var translation: CGSize {
//    .init(
//      width: current.x - start.x,
//      height: current.y - start.y
//    )
//  }
//
//  var isDrag: Bool {
//    hypot(translation.width, translation.height) >= dragThreshold
//  }
//
//  var rect: CGRect {
//    CGRect(
//      origin: start,
//      size: translation
//    ).standardized
//  }
//}

//enum PointerInteraction {
//  case tap(CGPoint)
//  case drag(CGRect)
//  case hover(CGPoint)
//  case longPress(CGPoint)
//}
