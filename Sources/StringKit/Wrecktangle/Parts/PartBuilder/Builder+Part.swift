//
//  Thing.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 4/11/2025.
//

import Foundation


@resultBuilder
enum PartBuilder {
  static func buildBlock(_ components: any RowConvertible...) -> Box.GlyphStack {
    components.map { $0.asGlyphRow() }
  }
  
  static func buildEither(first component: Box.GlyphStack) -> Box.GlyphStack {
    component
  }
  
  static func buildEither(second component: Box.GlyphStack) -> Box.GlyphStack {
    component
  }
  
  static func buildOptional(_ component: Box.GlyphStack?) -> Box.GlyphStack {
    component ?? []
  }
}

extension PartBuilder {
  
  static func buildExpression(_ expression: some RowConvertible) -> Box.GlyphStack {
    [expression.asGlyphRow()]
  }
  
//  static func buildExpression(_ expression: Row) -> Box.GlyphStack {
//    [expression.asGlyphRow()]
//  }

}
