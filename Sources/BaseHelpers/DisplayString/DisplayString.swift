//
//  Model+DisplayString.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 2/10/2025.
//

import Foundation

public struct DisplayString {

  private let components: [StyledString]

  /// This is the *top-level* seperator, that appears between
  /// each element in the builder (defined on a new line in
  /// the source code). Defaults to and is frequently set to
  /// a new line character `"\n"`
  private let separator: String

  public init(
    _ separator: String = "\n",
    @DisplayStringBuilder _ content: () -> [StyledString]
  ) {
    self.separator = separator
    self.components = content()
  }
}

extension DisplayString {

  public var output: String {
    components.map(\.plainString).joined(separator: separator)
  }
  
  public var outputStyled: AttributedString {
    components.map(\.styledString).joined(separator)
  }
  
//  public var output: String {
//    components.map(\.styledString).joined(separator).toString
//    //    components.map { $0.styledString.toString }.joined(separator)
//  }
//
//  public var outputStyled: AttributedString {
//    components.map(\.styledString).joined(separator)
//  }
}

extension DisplayString: StyledStringConvertible {
  public func toStyledString() -> StyledString {
    StyledString(self.outputStyled)
  }
}
