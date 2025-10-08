//
//  SequenceBuilder.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 3/10/2025.
//

import Foundation
import SharedHelpers

public typealias BuilderElement = DisplayElement
//public typealias BuilderElement = StyledString

@resultBuilder
public struct DisplayStringBuilder {

  public static func buildBlock(_ components: [BuilderElement]...) -> [BuilderElement] {
    printPadded("Ran DisplayStringBuilder.buildBlock", )
    return components.flatMap { $0 }
  }

  public static func buildOptional(_ component: [BuilderElement]?) -> [BuilderElement] {
    component ?? []
  }

  public static func buildEither(first component: [BuilderElement]) -> [BuilderElement] {
    component
  }

  public static func buildEither(second component: [BuilderElement]) -> [BuilderElement] {
    component
  }

  public static func buildArray(_ components: [[BuilderElement]]) -> [BuilderElement] {
    components.flatMap { $0 }
  }
  
  private static func debugString(
    components: [BuilderElement],
    function: String = #function,
  ) -> String {
    "\(function): \(components.count) elements"
//    let componentName = components.reduce("") { $0 + "\($1.isIndented ? "Indented" : "Plain"))"
    }
}

// MARK: - buildExpression overloads
extension DisplayStringBuilder {

  /// Allows for using both arrays and single items
  public static func buildExpression(_ expression: [BuilderElement]) -> [BuilderElement] {
    expression
  }

  public static func buildExpression(_ expression: BuilderElement) -> [BuilderElement] {
    [expression]
  }

  public static func buildExpression<T: StyledStringConvertible>(_ value: T) -> [BuilderElement] {
    [.text(value.toStyledString)]

  }

  public static func buildExpression(_ value: Indented) -> [BuilderElement] {
    [
      .indented(
        title: value.title,
        indent: value.indentString,
        content: value.content
      )
    ]
  }

}
