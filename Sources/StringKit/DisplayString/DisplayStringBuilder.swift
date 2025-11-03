//
//  SequenceBuilder.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 3/10/2025.
//

import Foundation
import SharedHelpers

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

  //  private static func debugString(
  //    components: [DisplayBlock],
  //    function: String = #function,
  //  ) -> String {
  //    "\(function): \(components.count) elements"
  //    //    let componentName = components.reduce("") { $0 + "\($1.isIndented ? "Indented" : "Plain"))"
  //  }
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

  public static func buildExpression<T: StyledStringConvertible>(_ value: T) -> [DisplayBlock] {
    [.text(value.toStyledString)]

  }

  public static func buildExpression(_ value: Indented) -> [DisplayBlock] {
    [
      .indented(
        Indented(
          value.title,
          indentString: value.indentString,
          content: value.content
        )
      )
    ]
  }

}
