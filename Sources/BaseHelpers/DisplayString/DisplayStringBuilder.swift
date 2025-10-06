//
//  SequenceBuilder.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 3/10/2025.
//

import Foundation

public typealias BuilderElement = StyledString

@resultBuilder
public struct DisplayStringBuilder {

  public static func buildBlock(_ components: [BuilderElement]...) -> [BuilderElement] {
    components.flatMap { $0 }
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

  /// This handles specific types, anything from `String`
  /// to `AttributedString` to `Indented`
  public static func buildExpression<T: StyledStringConvertible>(_ value: T) -> [StyledString] {
    [value.toStyledString()]
  }
}
