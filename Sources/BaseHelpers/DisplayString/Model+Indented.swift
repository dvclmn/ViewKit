//
//  Model+Indented.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 4/10/2025.
//

import Foundation

public struct Indented {
  public let title: String?
  public let prefix: String
  public let content: [BuilderElement]
  
  public init(
    _ title: String? = nil,
    prefix: String = "  | ",
    @DisplayStringBuilder _ content: () -> [BuilderElement]
  ) {
    self.title = title
    self.prefix = prefix
    self.content = content()
  }
}

extension Indented: DisplayStringConvertible {
  
  public func toDisplayString() -> StyledString {
    
    
    let indentedItems = content.map { prefix + $0.string }
      .joined(separator: "\n")
    guard let title else {
      return indentedItems
    }
    return title + "\n" + indentedItems
  }
}
