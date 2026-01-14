//
//  Pointer.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 12/1/2026.
//

import CoreTools
import SwiftUI

public struct PointerState {

  //  private(set) var rect: CGRect?

  /// Aka Drag rect origin point. If a drag is detected, this is the origin.
  /// *Does not* refer to a tap/hover location
  private(set) var start: CGPoint?

  /// Current pointer location. If `start` is `nil`, this is likely
  /// a tap/hover. If non-nil, this is the part of the rect anchored to the pointer
  private(set) var current: CGPoint?

  private(set) var kind: PointerInteraction.Meta = .none
  var phase: InteractionPhase

  public let dragThreshold: CGFloat = 4
}

extension PointerState {

  public func getInteraction() -> PointerInteraction? {
    switch kind {
      case .drag:
        guard kind.isDrag, let dragRect else { return nil }
        return .drag(dragRect)

      case .tap:
        guard kind.isTap, let current else { return nil }
        return .tap(current)

      case .hover:
        guard kind.isHover, let current else { return nil }
        return .hover(current)

      case .none: return nil
    }
  }

  public var currentInteraction: PointerInteraction.Meta {
    kind
  }

  public static var initial: Self {
    //    .init(rect: .zero, phase: .ended)
    .init(start: .zero, current: .zero, phase: .ended)
  }

  public mutating func update(
    _ interaction: PointerInteraction,
    phase: InteractionPhase
  ) {
    switch interaction {
      case .tap(let point): setTap(at: point)
      case .drag(let rect): setDragIfPermitted(with: rect)
      case .hover(let point): setHover(at: point)
      case .none: reset()
    }
    self.phase = phase
  }

  public mutating func update(hoverPhase phase: HoverPhase) {
    switch phase {
      case .active(let location):
        update(.hover(location), phase: .changed)
      case .ended:
        update(.none, phase: .ended)
    }
  }

  private mutating func reset() {
    current = nil
    start = nil
    kind = .none
    phase = .none
  }

  private mutating func setTap(at location: CGPoint) {
    current = location
    start = nil
    kind = .tap
  }

  private mutating func setHover(at location: CGPoint) {
    current = location
    start = nil
    kind = .hover
  }

  private mutating func setDragIfPermitted(with rect: CGRect) {

    guard isDragPermitted(for: rect.size) else {
      setTap(at: rect.origin)
      return
    }

    /// On first drag event, if `start` is nil, capture the origin as the start.
    if start == nil { start = rect.origin }
    /// Update current to the far corner of the rect so translation reflects size.
    current = CGPoint(x: rect.maxX, y: rect.maxY)
    kind = .drag
  }

  public var translation: CGSize? {
    guard let current, let start else { return nil }
    let result = CGSize(
      width: current.x - start.x,
      height: current.y - start.y
    )
    let isValidDrag = isDragPermitted(for: result)
    return isValidDrag ? result : nil
  }

  /// Returns true if the current pointer state indicates that it is of
  /// type Drag; not a Tap, nor a Hover
  private func isDragPermitted(for translation: CGSize) -> Bool {
    translation.diagonalLength >= dragThreshold
    //    hypot(translation.width, translation.height) >= dragThreshold
  }

  public var dragRect: CGRect? {
    guard let translation, let start else { return nil }
    return CGRect(origin: start, size: translation).standardized
  }
}
