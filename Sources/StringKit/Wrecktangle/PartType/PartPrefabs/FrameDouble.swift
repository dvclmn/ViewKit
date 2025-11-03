//
//  FrameDouble.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 30/10/2025.
//

extension Box.PartType {
  //extension Box.FrameStyle {

  /// Follows a `Prominence.increased` on the external frame parts,
  /// and  `Prominence.standard` on the internal parts
  public func double(
    //    for partType: Box.PartType,
    extProm: Box.GlyphProminence,
    intProm: Box.GlyphProminence,
    //    with arrangement: Box.ProminenceArrangement
  ) -> Box.GlyphStack {

    //    let prom01 = arrangement.doubleFrameGlyphProminence(for: partType).0
    //    let prom02 = arrangement.doubleFrameGlyphProminence(for: partType).1

    switch self {
      case .horizontal(let loc):
        switch loc {
          case .top:
            [
              [
                Box.GlyphType.horizontal(extProm),
                Box.GlyphType.blank,
                Box.GlyphType.horizontal(intProm),
              ]
            ]
          case .bottom:
            [
              [
                Box.GlyphType.horizontal(intProm),
                Box.GlyphType.blank,
                Box.GlyphType.horizontal(extProm),
              ]
            ]
          case .interior:
            [[Box.GlyphType.horizontal(intProm)]]
        }
      //
      case .vertical(let loc):
        switch loc {
          case .leading:
            [
              [
                Box.GlyphType.vertical(extProm),
                Box.GlyphType.blank,
                Box.GlyphType.vertical(intProm),
              ]
            ]
          case .trailing:
            [
              [
                Box.GlyphType.vertical(intProm),
                Box.GlyphType.blank,
                Box.GlyphType.vertical(extProm),
              ]
            ]
          case .interior:
            [[Box.GlyphType.vertical(intProm)]]
        }

      case .join(let joinType):
        switch joinType {
          case .leading:
            [
              [
                Box.GlyphType.vertical(extProm),
                Box.GlyphType.blank,
                Box.GlyphType.join(
                  x: intProm,
                  y: intProm,
                  type: joinType
                ),
              ]
            ]
          case .trailing:
            [
              [
                Box.GlyphType.join(
                  x: intProm,
                  y: intProm,
                  type: joinType
                ),
                Box.GlyphType.blank,
                Box.GlyphType.vertical(extProm),
              ]
            ]

          case .top:
            [
              [
                Box.GlyphType.horizontal(extProm),
                Box.GlyphType.blank,
                Box.GlyphType.join(
                  x: intProm,
                  y: intProm,
                  type: joinType
                ),
              ]
            ]

          case .bottom:
            [
              [
                Box.GlyphType.join(
                  x: intProm,
                  y: intProm,
                  type: joinType
                ),
                Box.GlyphType.blank,
                Box.GlyphType.horizontal(extProm),
              ]
            ]

          case .cross:
            [
              [
                Box.GlyphType.join(
                  x: intProm,
                  y: intProm,
                  type: joinType
                )
              ]
            ]
        }

      case .corner(let cornerType):
        switch cornerType {
          case .topLeading:
            [
              [
                Box.GlyphType.corner(.increased, type: cornerType),
                Box.GlyphType.horizontal(.increased),
                Box.GlyphType.horizontal(.increased),
              ],
              [
                Box.GlyphType.vertical(.increased),
                Box.GlyphType.blank,
                Box.GlyphType.corner(.standard, type: cornerType),
              ],
            ]
          case .topTrailing:
            [
              [
                Box.GlyphType.corner(.increased, type: cornerType),
                Box.GlyphType.horizontal(.increased),
                Box.GlyphType.horizontal(.increased),
              ],
              [
                Box.GlyphType.vertical(.increased),
                Box.GlyphType.blank,
                Box.GlyphType.corner(.standard, type: cornerType),
              ],
            ]
          case .bottomLeading:
            [
              [
                Box.GlyphType.corner(.increased, type: cornerType),
                Box.GlyphType.horizontal(.increased),
                Box.GlyphType.horizontal(.increased),
              ],
              [
                Box.GlyphType.vertical(.increased),
                Box.GlyphType.blank,
                Box.GlyphType.corner(.standard, type: cornerType),
              ],
            ]
          case .bottomTrailing:
            [
              [
                Box.GlyphType.corner(.increased, type: cornerType),
                Box.GlyphType.horizontal(.increased),
                Box.GlyphType.horizontal(.increased),
              ],
              [
                Box.GlyphType.vertical(.increased),
                Box.GlyphType.blank,
                Box.GlyphType.corner(.standard, type: cornerType),
              ],
            ]
        }
      //        doubleCorner(for: cornerType)

      case .text:
        /// Not sure yet what to do for text
        [[Box.GlyphType.blank]]

      case .blank:
        [[Box.GlyphType.blank]]

    }

    //    let result =
    //    switch self {
    //
    //    }  // END switch self

  }  // END frame double
  //    return result

  //    func doubleJoin(
  //      for type: Box.JoinType,
  ////      with arrangement: Box.ProminenceArrangement
  //    ) -> Box.GlyphStack {
  //      switch type {
  //        case .leading:
  //          [
  //            [
  //              Box.GlyphType.vertical(prom01),
  //              Box.GlyphType.blank,
  //              Box.GlyphType.join(x: .standard, y: .standard, type: type),
  //            ]
  //          ]
  //
  //        case .trailing:
  //          [
  //            [
  //              Box.GlyphType.join(x: .standard, y: .standard, type: type),
  //              Box.GlyphType.blank,
  //              Box.GlyphType.vertical(.increased),
  //            ]
  //          ]
  //
  //        case .top:
  //          [
  //            [Box.GlyphType.horizontal(.increased)],
  //            [Box.GlyphType.join(x: .standard, y: .standard, type: type)],
  //          ]
  //
  //        case .bottom:
  //          [
  //            [Box.GlyphType.join(x: .standard, y: .standard, type: type)],
  //            [Box.GlyphType.horizontal(.increased)],
  //          ]
  //        case .cross:
  //          [[Box.GlyphType.join(x: .standard, y: .standard, type: type)]]
  //      }
  //
  //    }  // END double join

  //  private func doubleCorner(for type: Box.CornerType) -> Box.GlyphStack {
  //    switch type {
  //
  //      /// Example:
  //      /// ```
  //      /// ["┏","━","━"],
  //      ///
  //      /// ["┃"," ","┌"]
  //      ///
  //      /// // Output:
  //      /// ┏━━
  //      /// ┃ ┌
  //      ///
  //      /// ```
  //      case .topLeading:
  //        [
  //          [
  //            Box.GlyphType.corner(.increased, type: type),
  //            Box.GlyphType.horizontal(.increased),
  //            Box.GlyphType.horizontal(.increased),
  //          ],
  //          [
  //            Box.GlyphType.vertical(.increased),
  //            Box.GlyphType.blank,
  //            Box.GlyphType.corner(.standard, type: type),
  //          ],
  //        ]
  //
  //      case .topTrailing:
  //        [
  //          [
  //            Box.GlyphType.horizontal(.increased),
  //            Box.GlyphType.horizontal(.increased),
  //            Box.GlyphType.corner(.increased, type: type),
  //          ],
  //          [
  //            Box.GlyphType.corner(.standard, type: type),
  //            Box.GlyphType.blank,
  //            Box.GlyphType.vertical(.increased),
  //          ],
  //        ]
  //
  //      case .bottomLeading:
  //        [
  //          [
  //            Box.GlyphType.vertical(.increased),
  //            Box.GlyphType.blank,
  //            Box.GlyphType.corner(.standard, type: type),
  //          ],
  //          [
  //            Box.GlyphType.corner(.increased, type: type),
  //            Box.GlyphType.horizontal(.increased),
  //            Box.GlyphType.horizontal(.increased),
  //          ],
  //        ]
  //      case .bottomTrailing:
  //        [
  //          [
  //            Box.GlyphType.corner(.standard, type: type),
  //            Box.GlyphType.blank,
  //            Box.GlyphType.vertical(.increased),
  //          ],
  //          [
  //            Box.GlyphType.horizontal(.increased),
  //            Box.GlyphType.horizontal(.increased),
  //            Box.GlyphType.corner(.increased, type: type),
  //          ],
  //        ]
  //    }  // END switch self
  //  }  // END glyph stack

}
