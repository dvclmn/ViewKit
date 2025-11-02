//
//  PartType+Corner.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 30/10/2025.
//

extension Box {

  public enum CornerType: Hashable, Sendable, Codable {
    case topLeading
    case topTrailing
    case bottomLeading
    case bottomTrailing
  }

}
extension Box.CornerType {

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
            Box.GlyphType.corner(.bold, type: self),
            Box.GlyphType.horizontal(.bold),
            Box.GlyphType.horizontal(.bold),
          ],
          [
            Box.GlyphType.vertical(.bold),
            Box.GlyphType.blank,
            Box.GlyphType.corner(.thin, type: self),
          ],
        ]

      case .topTrailing:
        [
          [
            Box.GlyphType.horizontal(.bold),
            Box.GlyphType.horizontal(.bold),
            Box.GlyphType.corner(.bold, type: self),
          ],
          [
            Box.GlyphType.corner(.thin, type: self),
            Box.GlyphType.blank,
            Box.GlyphType.vertical(.bold),
          ],
        ]

      case .bottomLeading:
        [
          [
            Box.GlyphType.vertical(.bold),
            Box.GlyphType.blank,
            Box.GlyphType.corner(.thin, type: self),
          ],
          [
            Box.GlyphType.corner(.bold, type: self),
            Box.GlyphType.horizontal(.bold),
            Box.GlyphType.horizontal(.bold),
          ],
        ]
      case .bottomTrailing:
        [
          [
            Box.GlyphType.corner(.thin, type: self),
            Box.GlyphType.blank,
            Box.GlyphType.vertical(.bold),
          ],
          [
            Box.GlyphType.horizontal(.bold),
            Box.GlyphType.horizontal(.bold),
            Box.GlyphType.corner(.bold, type: self),
          ],
        ]
    }  // END switch self
  }  // END glyph stack

}
