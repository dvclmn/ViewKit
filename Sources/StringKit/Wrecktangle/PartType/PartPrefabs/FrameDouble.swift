//
//  FrameDouble.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 30/10/2025.
//

extension Box.FrameStyle {

  /// Follows a `Prominence.strong` on the external frame parts,
  /// and  `Prominence.light` on the internal parts
  func double(
    for partType: Box.PartType,
    with arrangement: Box.ProminenceArrangement
  ) -> Box.GlyphStack {

    let prom01 = arrangement.doubleFrameGlyphProminence(for: partType).0
    let prom02 = arrangement.doubleFrameGlyphProminence(for: partType).1

    switch partType {

      case .horizontal(.top):
        [
          [
            Box.GlyphType.horizontal(prom01),
            Box.GlyphType.blank,
            Box.GlyphType.horizontal(prom02),
          ]
        ]

      case .horizontal(.bottom):
        [
          [
            Box.GlyphType.horizontal(prom01),
            Box.GlyphType.blank,
            Box.GlyphType.horizontal(prom02),
          ]
        ]

      case .horizontal(.interior):
        [[Box.GlyphType.horizontal(prom01)]]

      case .vertical(.leading):
        [
          [
            Box.GlyphType.vertical(part01),
            Box.GlyphType.blank,
            Box.GlyphType.vertical(part02),
          ]
        ]

      case .vertical(.trailing):
        [
          [
            Box.GlyphType.vertical(part01),
            Box.GlyphType.blank,
            Box.GlyphType.vertical(part02),
          ]
        ]
        
      case .vertical(.interior):
        [[Box.GlyphType.vertical(part01)]]

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

    private func doubleJoin(
      for type: Box.JoinType,
//      with arrangement: Box.ProminenceArrangement
    ) -> Box.GlyphStack {
      switch type {
        case .leading:
          [
            [
              Box.GlyphType.vertical(prom01),
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

  }  // END frame double

  
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
