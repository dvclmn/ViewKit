//
//  Pointer.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 12/1/2026.
//

import BasePrimitives
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
      case .active(let location): update(location)
      case .ended: update(nil)
    }
  }
}
