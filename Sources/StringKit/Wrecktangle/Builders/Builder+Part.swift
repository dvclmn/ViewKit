//
//  Thing.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 4/11/2025.
//

import Foundation

@resultBuilder
enum PartBuilder {
  
  static func buildBlock(_ components: any RowConvertible...) -> GlyphStack {
    components.map { $0.asGlyphRow() }
  }

  static func buildEither(first: GlyphStack) -> GlyphStack { first }
  static func buildEither(second: GlyphStack) -> GlyphStack { second }

  static func buildOptional(_ component: GlyphStack?) -> GlyphStack {
    component ?? []
  }
}
