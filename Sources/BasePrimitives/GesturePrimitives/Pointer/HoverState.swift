//
//  Pointer.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 12/1/2026.
//

import Foundation

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

  //  public mutating func update(_ phase: HoverPhase) {
  //    switch phase {
  //      case .active(let location): update(location)
  //      case .ended: update(nil)
  //    }
  //  }

  //  public mutating func updatePhase(_ phase: HoverPhase) {
  //    switch phase {
  //      case .active(let location): update(location)
  //      case .ended: update(nil)
  //    }
  //  }
}
