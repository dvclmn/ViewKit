//
//  FrameDouble.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 30/10/2025.
//

extension Box.FrameStyle {

  //  public static func prefab(for style: Box.FrameStyle)

  func double(for partType: Box.PartType) -> Box.GlyphStack {

    switch partType {

      case .horizontal(.top):
        [
          [Box.GlyphType.horizontal(.bold)],
          [Box.GlyphType.horizontal(.thin)],
        ]

      case .horizontal(.bottom):
        [
          [Box.GlyphType.horizontal(.thin)],
          [Box.GlyphType.horizontal(.bold)],
        ]

      case .horizontal(.interior):
        [[Box.GlyphType.horizontal(.thin)]]

      case .vertical(.leading):
        [
          [
            Box.GlyphType.vertical(.bold),
            Box.GlyphType.blank,
            Box.GlyphType.vertical(.thin),
          ]
        ]

      case .vertical(.trailing):
        [
          [
            Box.GlyphType.vertical(.thin),
            Box.GlyphType.blank,
            Box.GlyphType.vertical(.bold),
          ]
        ]
      case .vertical(.interior):
        [[Box.GlyphType.vertical(.thin)]]

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
            Box.GlyphType.vertical(.bold),
            Box.GlyphType.blank,
            Box.GlyphType.join(weightX: .thin, weightY: .thin, type: type),
          ]
        ]

      case .trailing:
        [
          [
            Box.GlyphType.join(weightX: .thin, weightY: .thin, type: type),
            Box.GlyphType.blank,
            Box.GlyphType.vertical(.bold),
          ]
        ]

      case .top:
        [
          [Box.GlyphType.horizontal(.bold)],
          [Box.GlyphType.join(weightX: .thin, weightY: .thin, type: type)],
        ]

      case .bottom:
        [
          [Box.GlyphType.join(weightX: .thin, weightY: .thin, type: type)],
          [Box.GlyphType.horizontal(.bold)],
        ]
      case .cross:
        [[Box.GlyphType.join(weightX: .thin, weightY: .thin, type: type)]]
    }

  } // END double join

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
            Box.GlyphType.corner(.bold, type: type),
            Box.GlyphType.horizontal(.bold),
            Box.GlyphType.horizontal(.bold),
          ],
          [
            Box.GlyphType.vertical(.bold),
            Box.GlyphType.blank,
            Box.GlyphType.corner(.thin, type: type),
          ],
        ]
        
      case .topTrailing:
        [
          [
            Box.GlyphType.horizontal(.bold),
            Box.GlyphType.horizontal(.bold),
            Box.GlyphType.corner(.bold, type: type),
          ],
          [
            Box.GlyphType.corner(.thin, type: type),
            Box.GlyphType.blank,
            Box.GlyphType.vertical(.bold),
          ],
        ]
        
      case .bottomLeading:
        [
          [
            Box.GlyphType.vertical(.bold),
            Box.GlyphType.blank,
            Box.GlyphType.corner(.thin, type: type),
          ],
          [
            Box.GlyphType.corner(.bold, type: type),
            Box.GlyphType.horizontal(.bold),
            Box.GlyphType.horizontal(.bold),
          ],
        ]
      case .bottomTrailing:
        [
          [
            Box.GlyphType.corner(.thin, type: type),
            Box.GlyphType.blank,
            Box.GlyphType.vertical(.bold),
          ],
          [
            Box.GlyphType.horizontal(.bold),
            Box.GlyphType.horizontal(.bold),
            Box.GlyphType.corner(.bold, type: type),
          ],
        ]
    }  // END switch self
  }  // END glyph stack

  
}
