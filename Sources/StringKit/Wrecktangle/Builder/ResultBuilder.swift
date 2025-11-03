//
//  ResultBuilder.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 3/11/2025.
//
import Foundation

@resultBuilder
public enum BoxBuilder {
  public static func buildBlock(_ components: [Box.Component]...) -> [Box.Component] {
    components.flatMap { $0 }
  }

  public static func buildExpression(_ string: String) -> Box.Component {
    Box.Text(string)
  }

  public static func buildOptional(_ component: [Box.Component]?) -> [Box.Component] {
    component ?? []
  }

  public static func buildEither(first: [Box.Component]) -> [Box.Component] { first }
  public static func buildEither(second: [Box.Component]) -> [Box.Component] { second }

  public static func buildArray(_ components: [[Box.Component]]) -> [Box.Component] {
    components.flatMap { $0 }
  }
}

extension BoxBuilder {

  /// Add support for a single Array...
  public static func buildExpression(_ component: [Box.Component]) -> [Box.Component] {
    component
  }

  /// ... and a single Block
  public static func buildExpression(_ component: Box.Component) -> [Box.Component] {
    [component]
  }

}
