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
  public let indentString: String
  public let content: [BuilderElement]

  public init(
    _ title: String? = nil,
    prefix indentString: String = " | ",
    @DisplayStringBuilder _ content: () -> [BuilderElement]
  ) {
    self.title = title
    self.indentString = indentString
    self.content = content()
  }
}

//extension Indented: StyledStringConvertible {
//  public var toStyledString: StyledString {
//    // Now you can access indentation depth!
//    let depth = contentElements.map(\.indentationDepth).max() ?? 0
//    let dynamicIndent = String(repeating: indentString, count: depth)
//
//    let indentedItems = contentElements.map { element in
//      dynamicIndent + element.toStyledString
//    }.joined("\n")
//
//    guard let title else { return indentedItems }
//    return title + "\n" + indentedItems
//  }
//}

//extension Indented: StyledStringConvertible {
//
//
//}
