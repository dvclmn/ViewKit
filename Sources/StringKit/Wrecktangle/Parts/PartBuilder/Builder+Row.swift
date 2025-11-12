//
//  Builder+Row.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 5/11/2025.
//

import Foundation

typealias RowComponent = Box.GlyphStructure

@resultBuilder
enum RowBuilder {
  static func buildBlock(_ components: [RowComponent]...) -> [RowComponent] {
    components.flatMap { $0 }
  }

  static func buildEither(first: [RowComponent]) -> [RowComponent] { first }
  static func buildEither(second: [RowComponent]) -> [RowComponent] { second }

  static func buildOptional(_ component: [RowComponent]?) -> [RowComponent] {
    component ?? []
  }
}

extension RowBuilder {
  static func buildExpression(_ expression: RowComponent) -> [RowComponent] {
    [expression]
  }
}
