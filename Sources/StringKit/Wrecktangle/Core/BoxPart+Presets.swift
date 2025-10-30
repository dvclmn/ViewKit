//
//  PartBuilder.swift
//  BoxCore
//
//  Created by Dave Coleman on 12/9/2024.
//

extension Box.PartType {

  /// This should be able to replace the old method, using 'archetype' glyphs
  /// that would then need to be swapped in.
  ///
  /// ```
  /// case .horizontal(.top):
  ///   content = [
  ///     ["━"],
  ///     ["─"]
  ///   ]
  /// ```
  ///
  public func preset(with frameStyle: Box.Theme.FrameStyle) -> [[Box.GlyphType]] {

    typealias Glyph = Box.GlyphType

    switch frameStyle {

      // MARK: - Single frame
      case .single:

        let output: Box.GlyphType

        switch self {

          case .horizontal(.top), .horizontal(.bottom):
            output = Glyph.horizontal(.exterior)

          case .horizontal(.interior):
            output = Glyph.horizontal(.interior)

          case .vertical(.leading), .vertical(.trailing):
            output = Glyph.vertical(.exterior)

          case .vertical(.interior):
            output = Glyph.vertical(.interior)

          case .join(let joinType):
            output = Glyph.join(x: .exterior, y: .exterior, type: joinType)

          case .corner(let cornerType):
            output = Glyph.corner(location: .exterior, type: cornerType)

        }  // END switch self

        return [[output]]

      // MARK: - Double frame
      case .double:

        let output: [[Box.GlyphType]]

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
            switch joinType {
              case .leading:
                output = [
                  [
                    Glyph.vertical(.exterior),
                    Glyph.blank,
                    /// I can use `joinType` directly here, as `PartType` and `GlyphType`
                    /// share the same type for describing joins
                    Glyph.join(x: .interior, y: .interior, type: joinType),
                  ]
                ]

              case .trailing:
                output = [
                  [
                    Glyph.join(x: .interior, y: .interior, type: joinType),
                    Glyph.blank,
                    Glyph.vertical(.exterior),
                  ]
                ]

              case .top:
                output = [
                  [Glyph.horizontal(.exterior)],
                  [Glyph.join(x: .interior, y: .interior, type: joinType)],
                ]
              case .bottom:
                output = [
                  [Glyph.join(x: .interior, y: .interior, type: joinType)],
                  [Glyph.horizontal(.exterior)],
                ]
              case .cross:
                output = [[Glyph.join(x: .interior, y: .interior, type: joinType)]]
            }

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

    }  // END switch frame style

  }

}

extension Box.BoxPart {

  public static func create(
    _ type: Box.PartType,
    with theme: Box.Theme
  ) -> Box.BoxPart {

    let glyphGrid = type.preset(with: theme.frameStyle)
    let characterGrid = glyphGrid.map { row in
      row.map { theme.glyphSet.character(for: $0) }
    }

    let multilineString = MultilineString(characterGrid)

    let finalResult: MultilineString

    //    switch theme.shadow.lightSource {
    //      case .bottomLeading:

    //    }

    //    switch type {
    //      case .vertical(.trailing):
    //        finalResult = addShadow(to: multilineString, with: theme)
    //
    //      default:
    //    }
    finalResult = multilineString

    //     else if theme.shadow.lightSource.hasShadow(.trailing) {
    //      finalResult = shadowResult + multilineString
    //    } else {
    //      finalResult = multilineString
    //    }

    //    print("Character grid:\n \(multilineString)")

    return Box.BoxPart(content: finalResult, type: type)
  }

  //  private static func addShadow(
  //    to string: MultilineString,
  //    with theme: BoxCore.Theme
  //  ) -> MultilineString {
  //
  //    let shadowHeight: Int = 1
  //    //    let shadowHeight: Int = theme.frameStyle.maximumGridSize.height.value
  //    let shadowString: [[Character]] = Array(repeating: [theme.shadow.strength.character], count: shadowHeight)
  //
  //    let shadowResult = MultilineString(shadowString)
  //
  //    if theme.shadow.lightSource.hasShadow(.leading)  {
  //      return string + shadowResult
  //    } else if theme.shadow.lightSource.hasShadow(.trailing) {
  //      return shadowResult + string
  //    } else {
  //      return string
  //    }
  //
  //  }
}
