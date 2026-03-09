//
//  TapState.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 9/3/2026.
//

public struct TapState: PointerAction {
  public var value: CGPoint?
  
  public init(_ value: Value? = nil) {
    self.value = value
  }
}
