//
//  Model+DisplayString.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 2/10/2025.
//

import Foundation

public struct DisplayString {

  private let content: [any StringConvertible]

  /// This is the *top-level* seperator, that appears between
  /// each element in the builder (defined on a new line in
  /// the source code). Defaults to and is frequently set to
  /// a new line character `"\n"`
  let separator: String

  public init(
    _ separator: String = "\n",
    @DisplayStringBuilder _ content: () -> [any StringConvertible]
  ) {
    self.separator = separator
    self.content = content()
  }
}

extension DisplayString {
  public var output: String {
    content.map(\.stringValue).joined(separator: separator)
  }
  
  public var outputStyled: AttributedString {
    content.map(\.stringValue).joined(separator: separator)
  }
}

extension DisplayString: StringConvertible {
  public var stringValue: String { String(describing: output) }
}

//extension String {
//  public func bold() -> String {
//    self
//  }
//}
