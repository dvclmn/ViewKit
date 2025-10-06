//
//  DS+Convertible.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 6/10/2025.
//

import Foundation

public protocol DisplayStringConvertible {
  func toDisplayString() -> StyledString
}

extension String: DisplayStringConvertible {
  public func toDisplayString() -> StyledString {
    .init(self)
  }
}

extension Int: DisplayStringConvertible {
  public func toDisplayString() -> StyledString {
    .init(self.toString)
  }
}
