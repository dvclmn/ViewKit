//
//  FrameDouble.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 30/10/2025.
//

extension Box.FrameStyle {

  /// Follows a `Prominence.strong` on the external frame parts,
  /// and  `Prominence.light` on the internal parts
  func double(for partType: Box.PartType) -> Box.GlyphStack {

    switch partType {

      case .horizontal(.top):
        [
          [Box.GlyphType.horizontal(.strong)],
          [Box.GlyphType.horizontal(.light)],
        ]

      case .horizontal(.bottom):
        [
          [Box.GlyphType.horizontal(.light)],
          [Box.GlyphType.horizontal(.strong)],
        ]

      case .horizontal(.interior):
        [[Box.GlyphType.horizontal(.light)]]

      case .vertical(.leading):
        [
          [
            Box.GlyphType.vertical(.strong),
            Box.GlyphType.blank,
            Box.GlyphType.vertical(.light),
          ]
        ]

      case .vertical(.trailing):
        [
          [
            Box.GlyphType.vertical(.light),
            Box.GlyphType.blank,
            Box.GlyphType.vertical(.strong),
          ]
        ]
      case .vertical(.interior):
        [[Box.GlyphType.vertical(.light)]]

      case .join(let joinType):
        doubleJoin(for: joinType)

      case .corner(let cornerType):
        doubleCorner(for: cornerType)

      case .text(let string):
        /// Not sure yet what to do for text
        []

      case .blank:
        [[Box.GlyphType.blank]]

    }  // END switch self

  }  // END frame double

  private func doubleJoin(for type: Box.JoinType) -> Box.GlyphStack {
    switch type {
      case .leading:
        [
          [
            Box.GlyphType.vertical(.strong),
            Box.GlyphType.blank,
            Box.GlyphType.join(x: .light, y: .light, type: type),
          ]
        ]

      case .trailing:
        [
          [
            Box.GlyphType.join(x: .light, y: .light, type: type),
            Box.GlyphType.blank,
            Box.GlyphType.vertical(.strong),
          ]
        ]

      case .top:
        [
          [Box.GlyphType.horizontal(.strong)],
          [Box.GlyphType.join(x: .light, y: .light, type: type)],
        ]

      case .bottom:
        [
          [Box.GlyphType.join(x: .light, y: .light, type: type)],
          [Box.GlyphType.horizontal(.strong)],
        ]
      case .cross:
        [[Box.GlyphType.join(x: .light, y: .light, type: type)]]
    }

  }  // END double join

  private func doubleCorner(for type: Box.CornerType) -> Box.GlyphStack {
    switch type {

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
            Box.GlyphType.corner(.strong, type: type),
            Box.GlyphType.horizontal(.strong),
            Box.GlyphType.horizontal(.strong),
          ],
          [
            Box.GlyphType.vertical(.strong),
            Box.GlyphType.blank,
            Box.GlyphType.corner(.light, type: type),
          ],
        ]

      case .topTrailing:
        [
          [
            Box.GlyphType.horizontal(.strong),
            Box.GlyphType.horizontal(.strong),
            Box.GlyphType.corner(.strong, type: type),
          ],
          [
            Box.GlyphType.corner(.light, type: type),
            Box.GlyphType.blank,
            Box.GlyphType.vertical(.strong),
          ],
        ]

      case .bottomLeading:
        [
          [
            Box.GlyphType.vertical(.strong),
            Box.GlyphType.blank,
            Box.GlyphType.corner(.light, type: type),
          ],
          [
            Box.GlyphType.corner(.strong, type: type),
            Box.GlyphType.horizontal(.strong),
            Box.GlyphType.horizontal(.strong),
          ],
        ]
      case .bottomTrailing:
        [
          [
            Box.GlyphType.corner(.light, type: type),
            Box.GlyphType.blank,
            Box.GlyphType.vertical(.strong),
          ],
          [
            Box.GlyphType.horizontal(.strong),
            Box.GlyphType.horizontal(.strong),
            Box.GlyphType.corner(.strong, type: type),
          ],
        ]
    }  // END switch self
  }  // END glyph stack

}
