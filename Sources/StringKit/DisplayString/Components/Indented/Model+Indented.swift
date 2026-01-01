//
//  Model+Indented.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 4/10/2025.
//

import Foundation

/// When `Indented` has it's own `buildExpression`, conformance
/// to `StyledStringConvertible` is not needed nor read
public struct Indented {
  public let title: String?
  public let content: [DisplayBlock]

  public init(
    _ title: String? = nil,
    @DisplayStringBuilder _ content: () -> [DisplayBlock]
  ) {
    self.title = title
    self.content = content()
  }
  
//  public init(
//    _ title: String? = nil,
//    content: [DisplayBlock]
//  ) {
//    self.title = title
//    self.content = content
//  }
}
