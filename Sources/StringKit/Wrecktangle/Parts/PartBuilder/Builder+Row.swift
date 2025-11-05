//
//  Builder+Row.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 5/11/2025.
//


// MARK: - Part Builders
@resultBuilder
enum RowBuilder {
  static func buildBlock(
    _ components: Box.GlyphType...
  ) -> [Box.GlyphType] {
    components
  }
  
//  static func buildEither(
//    first components: Box.GlyphType
//  ) -> [Box.GlyphType] {
//    [
//      components
//    ]
//  }
//  
//  static func buildEither(
//    second components: Box.GlyphType
//  ) -> [Box.GlyphType] {
//    [
//      components
//    ]
//  }
}

extension RowBuilder {
  /// Add support for a single Array...
//  public static func buildExpression(_ expression: [Box.GlyphType]) -> [Box.GlyphType] {
//    expression
//  }
  
//  public static func buildExpression(_ expression: [Box.GlyphType]...) -> [Box.GlyphType] {
//    expression.flatMap { $0 }
//  }
  
  /// ... and a single Block
//  public static func buildExpression(_ expression: Box.GlyphType) -> [Box.GlyphType] {
//    [expression]
//  }
}
