//
//  Model+Indented.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 4/10/2025.
//

import Foundation

public struct Indented {
  public let title: String?
  public let indentString: String
  public let content: [BuilderElement]

  public init(
    _ title: String? = nil,
    prefix indentString: String = "  | ",
    @DisplayStringBuilder _ content: () -> [BuilderElement]
  ) {
    self.title = title
    self.indentString = indentString
    self.content = content()
  }
}

extension Indented: StyledStringConvertible {

  public var toStyledString: StyledString {

    let indentedItems = content.map { indentString + $0 }.joined("\n")
    guard let title else {
      return indentedItems
    }
    return title + "\n" + indentedItems
  }
}
