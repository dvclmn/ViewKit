//
//  Builders+Test.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 5/11/2025.
//

extension Box {
  typealias Glyph = Box.GlyphType
  
  private struct BuildersTest {
    func testPart() -> Part {
      return Part {
        Row {
          Glyph.horizontal(.increased)
          Glyph.horizontal(.increased)
        }
      }
    }
  } // END test struct
}
