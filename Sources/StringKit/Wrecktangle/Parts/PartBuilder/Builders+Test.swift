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
