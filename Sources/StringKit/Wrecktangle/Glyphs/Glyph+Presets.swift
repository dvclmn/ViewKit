//
//  Glyph+Presets.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 9/11/2025.
//

extension Box.Glyph {
  static var thinJoins: [Self] {
    Glyph("┬", .join(.top))
    Glyph("┴", .join(.bottom))
    Glyph("├", .join(.leading))
    Glyph("┤", .join(.trailing))
    Glyph("┼", .join(.cross))

  }
}
