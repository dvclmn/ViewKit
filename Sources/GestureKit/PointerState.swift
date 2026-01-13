//
//  Pointer.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 12/1/2026.
//

import CoreTools
import Foundation

@MetaEnum
public enum PointerInteraction {
  //  case tap
  //  case drag
  //  case hover
  case tap(CGPoint)
  case drag(CGRect)
  case hover(CGPoint)
  case none
}

public struct PointerState {

  /// Aka Drag rect origin point. If a drag is detected, this is the origin.
  /// *Does not* refer to a tap/hover location
  private(set) var start: CGPoint?

  /// Current pointer location. If `start` is `nil`, this is likely
  /// a tap/hover. If non-nil, this is the part of the rect anchored to the pointer
  private(set) var current: CGPoint?

  private(set) var interactionKind: PointerInteraction.Meta = .none
  var phase: InteractionPhase

  let dragThreshold: CGFloat = 4
}

extension PointerState {
  public static var initial: Self {
    .init(start: .zero, current: .zero, phase: .ended)
  }

  public mutating func update(
    _ interaction: PointerInteraction,
    phase: InteractionPhase
  ) {
    switch interaction {
      case .tap(let point):
        setTap(at: point)

      case .drag(let rect):
        guard isDragPermitted(for: rect.size) else {
          setTap(at: rect.origin)
        }
        setDrag(with: rect)

      case .hover(let point):

      case .none:

    }
    self.phase = phase
  }
  
  private mutating func setTap(at location: CGPoint) {
    self.current = location
    self.start = nil
  }
  
  private mutating func setDrag(with rect: CGRect) {
    self.current = location
    self.start = nil
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
    hypot(translation.width, translation.height) >= dragThreshold
  }

  public var dragRect: CGRect? {
    guard let translation, let start else { return nil }
    return CGRect(origin: start, size: translation).standardized
  }
}
