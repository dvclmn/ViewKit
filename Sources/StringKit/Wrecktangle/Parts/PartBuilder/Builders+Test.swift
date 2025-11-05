//
//  Builders+Test.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 5/11/2025.
//

extension Box {  
  private struct BuildersTest {
    func testPart() -> Part {
      return Part {
        Row {
          // Cannot pass array of type '[Box.GlyphType]' as variadic arguments of type 'Box.GlyphType'
          if true {
            Glyph.horizontal(.increased)
          } else {
            Glyph.horizontal(.increased)
          }
        }
      }
    }
  } // END test struct
}
