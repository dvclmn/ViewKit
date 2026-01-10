//
//  SequenceBuilder.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 3/10/2025.
//

import Foundation
import BasePrimitives

@resultBuilder
public struct DisplayStringBuilder {

  public static func buildBlock(_ components: [DisplayBlock]...) -> [DisplayBlock] {
    components.flatMap { $0 }
  }

  public static func buildOptional(_ component: [DisplayBlock]?) -> [DisplayBlock] {
    component ?? []
  }

  public static func buildEither(first: [DisplayBlock]) -> [DisplayBlock] { first }
  public static func buildEither(second: [DisplayBlock]) -> [DisplayBlock] { second }

  public static func buildArray(_ components: [[DisplayBlock]]) -> [DisplayBlock] {
    components.flatMap { $0 }
  }
}

// MARK: - buildExpression overloads
extension DisplayStringBuilder {

  /// Add support for a single Array...
  public static func buildExpression(_ expression: [DisplayBlock]) -> [DisplayBlock] {
    expression
  }

  /// ... and a single Block
  public static func buildExpression(_ expression: DisplayBlock) -> [DisplayBlock] {
    [expression]
  }

    public static func buildExpression<T: StringConvertible>(_ value: T) -> [DisplayBlock] {
      [.text(value.toString)]
    }

  public static func buildExpression(_ value: Indented) -> [DisplayBlock] {
    [
      .indented(
        Indented(
          value.title,
          content: { value.content }
        )
      )
    ]
  }
}
