//
//  FrameDouble.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 30/10/2025.
//

extension Box.PartType {

  
  /// Follows a `Prominence.increased` on the external frame parts,
  /// and  `Prominence.standard` on the internal parts
  package func doubleFrameParts(
    extProm: Box.GlyphProminence,
    intProm: Box.GlyphProminence,
  ) -> Box.GlyphStack {

    switch self {
      case .horizontal(let loc):
        switch loc {
          case .top:
            [
              [Box.GlyphType.horizontal(extProm)],
              [Box.GlyphType.blank],
              [Box.GlyphType.horizontal(intProm)],

            ]
          case .bottom:
            [
              [Box.GlyphType.horizontal(intProm)],
              [Box.GlyphType.blank],
              [Box.GlyphType.horizontal(extProm)],

            ]
          case .interior:
            [[Box.GlyphType.horizontal(intProm)]]
        }

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

              [Box.GlyphType.vertical(extProm)],
              [Box.GlyphType.blank],
              [
                Box.GlyphType.join(
                  x: intProm,
                  y: intProm,
                  type: joinType
                )
              ],

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

      case .blank:
        [[Box.GlyphType.blank]]
    }
  }  // END frame double
}
