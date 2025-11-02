//
//  FrameDouble.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 30/10/2025.
//

extension Box.FrameStyle {

  /// Follows a `Prominence.increased` on the external frame parts,
  /// and  `Prominence.standard` on the internal parts
  func double(
    for partType: Box.PartType,
    exterior exteriorProm: Box.GlyphProminence,
    interior interiorProm: Box.GlyphProminence,
//    with arrangement: Box.ProminenceArrangement
  ) -> Box.GlyphStack {

//    let prom01 = arrangement.doubleFrameGlyphProminence(for: partType).0
//    let prom02 = arrangement.doubleFrameGlyphProminence(for: partType).1

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

    func doubleJoin(
      for type: Box.JoinType,
//      with arrangement: Box.ProminenceArrangement
    ) -> Box.GlyphStack {
      switch type {
        case .leading:
          [
            [
              Box.GlyphType.vertical(prom01),
              Box.GlyphType.blank,
              Box.GlyphType.join(x: .standard, y: .standard, type: type),
            ]
          ]
          
        case .trailing:
          [
            [
              Box.GlyphType.join(x: .standard, y: .standard, type: type),
              Box.GlyphType.blank,
              Box.GlyphType.vertical(.increased),
            ]
          ]
          
        case .top:
          [
            [Box.GlyphType.horizontal(.increased)],
            [Box.GlyphType.join(x: .standard, y: .standard, type: type)],
          ]
          
        case .bottom:
          [
            [Box.GlyphType.join(x: .standard, y: .standard, type: type)],
            [Box.GlyphType.horizontal(.increased)],
          ]
        case .cross:
          [[Box.GlyphType.join(x: .standard, y: .standard, type: type)]]
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
            Box.GlyphType.corner(.increased, type: type),
            Box.GlyphType.horizontal(.increased),
            Box.GlyphType.horizontal(.increased),
          ],
          [
            Box.GlyphType.vertical(.increased),
            Box.GlyphType.blank,
            Box.GlyphType.corner(.standard, type: type),
          ],
        ]

      case .topTrailing:
        [
          [
            Box.GlyphType.horizontal(.increased),
            Box.GlyphType.horizontal(.increased),
            Box.GlyphType.corner(.increased, type: type),
          ],
          [
            Box.GlyphType.corner(.standard, type: type),
            Box.GlyphType.blank,
            Box.GlyphType.vertical(.increased),
          ],
        ]

      case .bottomLeading:
        [
          [
            Box.GlyphType.vertical(.increased),
            Box.GlyphType.blank,
            Box.GlyphType.corner(.standard, type: type),
          ],
          [
            Box.GlyphType.corner(.increased, type: type),
            Box.GlyphType.horizontal(.increased),
            Box.GlyphType.horizontal(.increased),
          ],
        ]
      case .bottomTrailing:
        [
          [
            Box.GlyphType.corner(.standard, type: type),
            Box.GlyphType.blank,
            Box.GlyphType.vertical(.increased),
          ],
          [
            Box.GlyphType.horizontal(.increased),
            Box.GlyphType.horizontal(.increased),
            Box.GlyphType.corner(.increased, type: type),
          ],
        ]
    }  // END switch self
  }  // END glyph stack

}
