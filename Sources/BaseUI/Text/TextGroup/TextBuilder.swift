//
//  TextBuilder.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 30/10/2025.
//

import SwiftUI

@MainActor
@resultBuilder
public struct TextBuilder {
  
  /// Accepts array elements from each child expression
  public static func buildBlock(_ components: [Text]...) -> [Text] {
    components.flatMap { $0 }
  }
  
  public static func buildOptional(_ component: [Text]?) -> [Text] {
    component ?? []
  }
  
  public static func buildEither(first component: [Text]) -> [Text] {
    component
  }
  
  public static func buildEither(second component: [Text]) -> [Text] {
    component
  }
  
  public static func buildArray(_ components: [[Text]]) -> [Text] {
    components.flatMap { $0 }
  }
  
  /// Allow a single Text literal to be treated as an array of one
  public static func buildExpression(_ expression: Text) -> [Text] {
    [expression]
  }
}
