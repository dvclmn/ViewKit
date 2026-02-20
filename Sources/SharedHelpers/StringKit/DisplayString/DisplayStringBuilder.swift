//
//  SequenceBuilder.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 3/10/2025.
//

import BasePrimitives
import Foundation

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
  
  public static func buildExpression(_ value: Labeled) -> [DisplayBlock] {
    [.labeled(value)]
  }

  public static func buildExpression(_ value: any DisplayRenderable) -> [DisplayBlock] {
    [.display(value)]
  }
  
  public static func buildExpression(_ value: any FloatRenderable) -> [DisplayBlock] {
    [.float(value)]
  }

  public static func buildExpression(_ value: any PropertiesLabeled) -> [DisplayBlock] {
    [.floatGroup(value)]
  }

  public static func buildExpression(_ value: String) -> [DisplayBlock] {
    [.text(value)]
  }

  public static func buildExpression<T: StringRenderable>(_ value: T) -> [DisplayBlock] {
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

  public static func buildExpression(_ value: IndentedLines) -> [DisplayBlock] {
    guard !value.lines.isEmpty else { return [] }
    return [
      .indented(
        Indented(
          value.title,
          content: { value.lines.joined(separator: value.separator) }
        )
      )
    ]
  }
}
