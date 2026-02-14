//
//  Comp+Divider.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 17/11/2025.
//

public struct Divider {
  public let value: DisplayBlock

  public init(value: String = "----------\n") {
    self.value = .text(value)
  }
}
extension Divider: DisplayRenderable{
  public func render(using format: DisplayFormat) -> String {
    value.render(using: format)
  }
}
