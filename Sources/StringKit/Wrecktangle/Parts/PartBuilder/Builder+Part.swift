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

  static func buildEither(first: Box.GlyphStack) -> Box.GlyphStack { first }
  static func buildEither(second: Box.GlyphStack) -> Box.GlyphStack { second }

  static func buildOptional(_ component: Box.GlyphStack?) -> Box.GlyphStack {
    component ?? []
  }
}

extension PartBuilder {

//  static func buildExpression(_ expression: some RowConvertible) -> Box.GlyphStack {
//    [expression.asGlyphRow()]
//  }


  //  static func buildExpression(_ expression: Row) -> Box.GlyphStack {
  //    [expression.asGlyphRow()]
  //  }

}
