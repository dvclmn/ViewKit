//
//  Builder+Row.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 5/11/2025.
//

import Foundation

@resultBuilder
enum RowBuilder {

  typealias Component = Box.GlyphStructure
  static func buildBlock(_ components: [Component]...) -> [Component] {
    components.flatMap { $0 }
  }

  static func buildEither(first: [Component]) -> [Component] { first }
  static func buildEither(second: [Component]) -> [Component] { second }

  static func buildOptional(_ component: [Component]?) -> [Component] {
    component ?? []
  }
}

extension RowBuilder {
  static func buildExpression(_ expression: Component) -> [Component] {
    [expression]
  }
}
