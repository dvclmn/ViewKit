//
//  TapState.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 9/3/2026.
//

import Foundation

public struct TapState: TransientInteraction {
  public var value: CGPoint?

  public init(_ value: Value? = nil) {
    self.value = value
  }
}
