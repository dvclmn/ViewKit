//
//  Pointer.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 12/1/2026.
//

import Foundation

public struct HoverState: InteractionStateProtocol {
  public var value: CGPoint?

  public init(_ value: Value? = nil) {
    self.value = value
  }
}
