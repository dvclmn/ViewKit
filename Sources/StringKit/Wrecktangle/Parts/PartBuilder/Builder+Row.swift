//
//  Builder+Row.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 5/11/2025.
//

// MARK: - Part Builders
@resultBuilder
enum RowBuilder {
  static func buildBlock(_ components: Box.GlyphType...) -> [Box.GlyphType] {
    components
  }

  static func buildEither(first component: [Box.GlyphType]) -> [Box.GlyphType] {
    component
  }

  static func buildEither(second component: [Box.GlyphType]) -> [Box.GlyphType] {
    component
  }

  static func buildOptional(_ component: [Box.GlyphType]?) -> [Box.GlyphType] {
    component ?? []
  }
}

extension RowBuilder {
  static func buildExpression(_ expression: Box.GlyphType) -> [Box.GlyphType] {
    [expression]
  }
}
