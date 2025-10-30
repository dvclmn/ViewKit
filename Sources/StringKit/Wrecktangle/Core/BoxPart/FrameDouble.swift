//
//  FrameDouble.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 30/10/2025.
//

extension BoxPart.PartType {

  func frameDouble() -> Box.GlyphStack {

    let output: Box.GlyphStack

    switch self {

      case .horizontal(.top):
        output = [
          [Glyph.horizontal(.exterior)],
          [Glyph.horizontal(.interior)],
        ]

      case .horizontal(.bottom):
        output = [
          [Glyph.horizontal(.interior)],
          [Glyph.horizontal(.exterior)],
        ]

      case .horizontal(.interior):
        output = [
          [Glyph.horizontal(.interior)]
        ]

      case .vertical(.leading):
        output = [
          [Glyph.vertical(.exterior), Glyph.blank, Glyph.vertical(.interior)]
        ]

      case .vertical(.trailing):
        output = [
          [Glyph.vertical(.interior), Glyph.blank, Glyph.vertical(.exterior)]
        ]
      case .vertical(.interior):
        output = [
          [Glyph.vertical(.interior)]
        ]

      case .join(let joinType):
        output = joinType.glyphStack()
        
      case .corner(let cornerType):
        switch cornerType {

          /// # Example
          ///
          ///
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
          ///
          case .topLeading:
            output = [
              [
                Glyph.corner(location: .exterior, type: cornerType),
                Glyph.horizontal(.exterior),
                Glyph.horizontal(.exterior),
              ],
              [
                Glyph.vertical(.exterior),
                Glyph.blank,
                Glyph.corner(location: .interior, type: cornerType),
              ],
            ]

          case .topTrailing:
            output = [
              [
                Glyph.horizontal(.exterior),
                Glyph.horizontal(.exterior),
                Glyph.corner(location: .exterior, type: cornerType),
              ],
              [
                Glyph.corner(location: .interior, type: cornerType),
                Glyph.blank,
                Glyph.vertical(.exterior),
              ],
            ]

          case .bottomLeading:
            output = [
              [
                Glyph.vertical(.exterior),
                Glyph.blank,
                Glyph.corner(location: .interior, type: cornerType),
              ],
              [
                Glyph.corner(location: .exterior, type: cornerType),
                Glyph.horizontal(.exterior),
                Glyph.horizontal(.exterior),
              ],
            ]
          case .bottomTrailing:
            output = [
              [
                Glyph.corner(location: .interior, type: cornerType),
                Glyph.blank,
                Glyph.vertical(.exterior),
              ],
              [
                Glyph.horizontal(.exterior),
                Glyph.horizontal(.exterior),
                Glyph.corner(location: .exterior, type: cornerType),
              ],
            ]
        }
    }  // END switch self

    return output

  }
}
