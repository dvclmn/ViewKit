//
//  Model+DisplayString.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 2/10/2025.
//

import Foundation

public struct DisplayString {

  private let components: [StringComponent]

  /// This is the *top-level* seperator, that appears between
  /// each element in the builder (defined on a new line in
  /// the source code). Defaults to and is frequently set to
  /// a new line character `"\n"`
  let separator: String

  public init(
    _ separator: String = "\n",
    @DisplayStringBuilder _ content: () -> [StringComponent]
  ) {
    self.separator = separator
    self.components = content()
  }
}

extension DisplayString {
  public var output: String {
    components.map(\.plain).joined(separator: separator)
  }

  public var outputStyled: AttributedString {
    components.enumerated().reduce(into: AttributedString()) { result, element in
      let (index, component) = element
      result.append(component.attributed)
      if index < components.count - 1 {
        result.append(AttributedString(separator))
      }
    }
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
