//
//  PartGroup+Join.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 12/11/2025.
//

extension Box.PartStructure {
//extension Box.PartGroup {
  //extension Box.JoinType {

  static var doubleJoin: [Part] {
//  static var doubleJoin: Frame {
    PartGroup {
      
      Part(.join(.leading)) {
        Row {
          GlyphType.v(.increased)
          GlyphType.blank
          GlyphType.join(
            x: .standard,
            y: .standard,
          )
        }
      }

      Part(.join(.trailing)) {
        Row {
          GlyphType.join(
            x: .standard,
            y: .standard,
          )
          GlyphType.blank
          GlyphType.v(.increased)
        }
      }
//
      Part(.join(.top)) {
        Row {
          GlyphType.h(.increased)
          GlyphType.blank
          GlyphType.join(
            x: .standard,
            y: .standard,
          )
        }
      }

      Part(.join(.bottom)) {
        Row {
          GlyphType.join(
            x: .standard,
            y: .standard,
          )
          GlyphType.blank
          GlyphType.h(.increased)
        }
      }

      Part(.join(.cross)) {
        Row {
          GlyphType.join(
            x: .standard,
            y: .standard,
          )
        }
      }
    }.parts
    
  }
}
