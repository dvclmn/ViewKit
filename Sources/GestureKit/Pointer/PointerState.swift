//
//  Pointer.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 12/1/2026.
//

import CoreTools
import SwiftUI

public struct TapState: PointerAction {
  public var value: CGPoint?

  public init(_ value: Value? = nil) {
    self.value = value
  }
}

public struct DragState: PointerAction, Activatable {
  public var value: CGRect?
  public var isActive: Bool = false

  public let dragThreshold: CGFloat = 6

  public init(_ value: Value? = nil) {
    self.value = value
  }
}

public struct HoverState: PointerAction {
  public var value: CGPoint?

  public init(_ value: Value? = nil) {
    self.value = value
  }
}

extension HoverState {
  public var isActive: Bool {
    value != nil
  }

  public mutating func update(_ phase: HoverPhase) {
    switch phase {
      case .active(let location):
        update(location)
      case .ended:
        update(nil)
    }
  }
}

//public struct PointerState {
//
//  private(set) var tapOrHover: CGPoint?
//  private(set) var rect: CGRect?
//
//  private(set) var kind: PointerInteraction.Meta?
//
//  /// Mostly used, I think, for Dragging, not so much hover or tap?
////  var phase: InteractionPhase = .none
//
//  public let dragThreshold: CGFloat = 6
//
//  init(
//    //    tapOrHover: CGPoint? = nil,
//  //    rect: CGRect? = nil,
//  //    kind: PointerInteraction.Meta? = nil,
//  //    phase: InteractionPhase
//  ) {
//    //    self.tapOrHover = tapOrHover
//    //    self.rect = rect
//    //    self.kind = kind
//    //    self.phase = phase
//  }
//}

//extension PointerState {
//  public var isDragging: Bool {
//    (kind?.isDrag ?? false) && phase.isActive
//  }

/// This packages up the output neatly for the caller to work with
//  public var interactionData: PointerInteraction? {
//    switch kind {
//      case .drag:
//        guard let kind, kind.isDrag, let dragRect else { return nil }
//        return .drag(dragRect, phase)
//
//      case .tap:
//        guard let kind, kind.isTap, let tapOrHover else { return nil }
//        return .tap(tapOrHover)
//
//      case .hover:
//        guard let kind, kind.isHover, let tapOrHover else { return nil }
//        return .hover(tapOrHover)
//
//      case .none: return nil
//    }
//  }

//  public var currentInteraction: PointerInteraction.Meta? { kind }

//  public static var initial: Self { .init() }

//  public mutating func update(_ interaction: PointerInteraction?) {
//    guard let interaction else { return }
//    switch interaction {
//      case .tap(let point): setTap(at: point)
//      case .drag(let rect, let phase): setDragIfPermitted(with: rect, phase: phase)
//      case .hover(let point): setHover(at: point)
//    }
//  }
//
//  public mutating func update(hoverPhase phase: HoverPhase) {
//    switch phase {
//      case .active(let location): update(.hover(location))
//      case .ended: update(.hover(nil))
//    }
//  }

//  private mutating func reset() {
//    tapOrHover = nil
////    tap = nil
//    kind = .none
//    phase = .none
//  }
//
//  private mutating func setTap(at location: CGPoint) {
//    tapOrHover = location
////    tap = nil
//    kind = .tap
//    self.phase = .none
//  }
//
//  private mutating func setHover(at location: CGPoint?) {
//    tapOrHover = location
////    tap = nil
//    kind = .hover
//    if location == nil {
//      self.phase = .none
//    }
//  }

//  private mutating func setDragIfPermitted(
//    with rect: CGRect,
//    phase: InteractionPhase
//  ) {
//    guard isDragPermitted(for: rect.size) else {
//      //      setTap(at: rect.origin)
//      return
//    }
//    self.rect = rect
//    kind = .drag
//    self.phase = phase
//
//    /// On first drag event, if `start` is nil, capture the origin as the start.
////    if tap == nil { tap = rect.origin }
//    /// Update current to the far corner of the rect so translation reflects size.
////    tapOrHover = CGPoint(x: rect.maxX, y: rect.maxY)
//  }

//  public var translation: CGSize? {
//    guard let rect else { return nil }
////    guard let tapOrHover, let tap else { return nil }
//    let result = CGSize(
//      width: tapOrHover.x - tap.x,
//      height: tapOrHover.y - tap.y
//    )
//    let isValidDrag = isDragPermitted(for: result)
//    return isValidDrag ? result : nil
//  }

/// Returns true if the current pointer state indicates that it is of
/// type Drag; not a Tap, nor a Hover
//  private func isDragPermitted(for translation: CGSize) -> Bool {
//    translation.diagonalLength >= dragThreshold
//    //    hypot(translation.width, translation.height) >= dragThreshold
//  }

//  public var dragRect: CGRect? {
//    rect?.standardized
//    //    guard let translation, let start else { return nil }
//    //    return CGRect(origin: start, size: translation).standardized
//  }
//}
