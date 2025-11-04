//
//  Part+Builder.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 4/11/2025.
//

import Foundation

@resultBuilder

@resultBuilder
public enum BoxBuilder {
  public static func buildBlock(_ components: [any Box.Component]...) -> [any Box.Component] {
    components.flatMap { $0 }
  }
  
  public static func buildExpression(_ string: String) -> [any Box.Component] {
    [Box.Text(string)]
  }
  
  public static func buildOptional(_ component: [any Box.Component]?) -> [any Box.Component] {
    component ?? []
  }
  
  public static func buildEither(first: [any Box.Component]) -> [any Box.Component] { first }
  public static func buildEither(second: [any Box.Component]) -> [any Box.Component] { second }
  
  public static func buildArray(_ components: [[any Box.Component]]) -> [any Box.Component] {
    components.flatMap { $0 }
  }
}

extension BoxBuilder {
  
  /// Add support for a single Array...
  public static func buildExpression(_ component: [any Box.Component]) -> [any Box.Component] {
    component
  }
  
  /// ... and a single Block
  public static func buildExpression(_ component: any Box.Component) -> [any Box.Component] {
    [component]
  }
  
}
