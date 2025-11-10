//
//  Builders+Test.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 5/11/2025.
//

extension Box {  
  private struct BuildersTest {
    func testPart() -> PartResolved {
      return PartResolved(.blank) {
        Row {
          // Cannot pass array of type '[Box.GlyphType]' as variadic arguments of type 'Box.GlyphType'
          if true {
            GlyphDescriptor.h(.increased)
          } else {
            GlyphDescriptor.h(.increased)
          }
        }
      }
    }
  } // END test struct
}
