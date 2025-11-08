//
//  JoinPresets.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 8/11/2025.
//

extension Box.JoinType {
  static var doubleJoin: Self {
    Part(.join(.leading)) {
      Row {
        Glyph.vertical(.increased)
        Glyph.blank
        Glyph.join(x: .standard, y: .increased, type: .leading)
      }
    }
    
    Part(.join(.trailing)) {
      Row {
        Glyph.join(x: .standard, y: .standard, type: .trailing)
        Glyph.blank
        Glyph.vertical(.increased)
      }
    }
    
    Part(.join(.top)) {
      Row {
        Glyph.horizontal(.increased)
        Glyph.blank
        Glyph.join(x: .standard, y: .standard, type: .top)
      }
    }
    
    Part(.join(.bottom)) {
      Row {
        Glyph.join(x: .standard, y: .standard, type: .bottom)
        Glyph.blank
        Glyph.horizontal(.increased)
      }
    }
    
    Part(.join(.cross)) {
      Row {
        Glyph.join(x: .standard, y: .standard, type: .cross)
      }
    }
  }
}
