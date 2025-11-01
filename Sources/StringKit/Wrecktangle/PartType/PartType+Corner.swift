//
//  PartType+Corner.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 30/10/2025.
//

extension Box.PartType.Corner {
  func glyphStack() -> Box.GlyphStack {
    switch self {

      /// Example:
      /// ```
      /// ["┏","━","━"],
      ///
      /// ["┃"," ","┌"]
      ///
      /// // Output:
      /// ┏━━
      /// ┃ ┌
      ///
      /// ```
      case .topLeading:
        [
          [
            Box.GlyphType.corner(location: .exterior, type: self),
            Box.GlyphType.horizontal(.exterior),
            Box.GlyphType.horizontal(.exterior),
          ],
          [
            Box.GlyphType.vertical(.exterior),
            Box.GlyphType.blank,
            Box.GlyphType.corner(location: .interior, type: self),
          ],
        ]

      case .topTrailing:
        [
          [
            Box.GlyphType.horizontal(.exterior),
            Box.GlyphType.horizontal(.exterior),
            Box.GlyphType.corner(location: .exterior, type: self),
          ],
          [
            Box.GlyphType.corner(location: .interior, type: self),
            Box.GlyphType.blank,
            Box.GlyphType.vertical(.exterior),
          ],
        ]

      case .bottomLeading:
        [
          [
            Box.GlyphType.vertical(.exterior),
            Box.GlyphType.blank,
            Box.GlyphType.corner(location: .interior, type: self),
          ],
          [
            Box.GlyphType.corner(location: .exterior, type: self),
            Box.GlyphType.horizontal(.exterior),
            Box.GlyphType.horizontal(.exterior),
          ],
        ]
      case .bottomTrailing:
        [
          [
            Box.GlyphType.corner(location: .interior, type: self),
            Box.GlyphType.blank,
            Box.GlyphType.vertical(.exterior),
          ],
          [
            Box.GlyphType.horizontal(.exterior),
            Box.GlyphType.horizontal(.exterior),
            Box.GlyphType.corner(location: .exterior, type: self),
          ],
        ]
    }  // END switch self
  } // END glyph stack

}
