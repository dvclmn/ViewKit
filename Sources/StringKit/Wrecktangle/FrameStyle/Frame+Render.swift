//
//  Frame+Render.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 9/11/2025.
//

//extension Box {
//  /// Brings `FrameStyle` and `GlyphSet` together
//  struct FrameResolver {
//    static func resolve(style: FrameStyle, glyphs: GlyphSet) -> Frame {
//      let parts: PartMap = style.parts.mapValues { spec in
//        let glyphsForPart = spec.roles.map { row in
//          row.map { role in
//            glyphs.resolve(role: role) // returns GlyphType
//          }
//        }
//        return Part(type: spec.type, glyphs: glyphsForPart)
//      }
//      return Frame(parts: parts)
//    }
//  }
//}
//
