//
//  SequenceBuilder.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 3/10/2025.
//

import Foundation

/// Ideally this should stay simple/dumb, not concerned with formatting strings etc.
/// Just putting things together
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

  /// Overloads for dedicated Block Types ``Labeled``, ``Indented``, ``Divider`` etc
  
  public static func buildExpression(_ value: Labeled) -> [DisplayBlock] {
    [value.block]
  }

  public static func buildExpression(_ value: Indented) -> [DisplayBlock] {
    [.indented(value)]
  }

  public static func buildExpression(_ value: Divider) -> [DisplayBlock] {
    [.divider(value.toString)]
  }

  public static func buildExpression(_ value: IndentedLines) -> [DisplayBlock] {
    guard !value.lines.isEmpty else { return [] }
    return [.indented(Indented(fromLines: value))]
  }

  public static func buildExpression(_ value: any CustomStringConvertible) -> [DisplayBlock] {
    [.text(.make(from: value))]
  }
}
