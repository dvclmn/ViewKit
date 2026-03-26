//
//  Comp+Divider.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 17/11/2025.
//

public struct Divider {
  public let value: String

  public init(value: String = "----------\n") {
    self.value = value
  }
}

/// Have removed this as `DisplayRenderable` and `FloatRenderable`
/// is actually the same thing, and I think is only needed for floats (which Divider isn't)
extension Divider: StringRenderable {
  public var toString: String { value }
}
