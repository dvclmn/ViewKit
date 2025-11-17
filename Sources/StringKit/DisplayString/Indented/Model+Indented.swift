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
  
  @available(*, deprecated, message: "Custom index string is not supported")
  public let indentString: String
  public let content: [DisplayBlock]

  public init(
    _ title: String? = nil,
    prefix indentString: String = " | ",
    @DisplayStringBuilder _ content: () -> [DisplayBlock]
  ) {
    self.title = title
    self.indentString = indentString
    self.content = content()
  }
  
  public init(
    _ title: String? = nil,
    indentString: String = " | ",
    content: [DisplayBlock]
  ) {
    self.title = title
    self.indentString = indentString
    self.content = content
  }
}
