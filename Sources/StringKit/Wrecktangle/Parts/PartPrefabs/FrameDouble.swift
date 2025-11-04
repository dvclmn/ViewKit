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
            GlyphGrid {
              Row {
                Box.GlyphType.vertical(extProm)
                Box.GlyphType.blank
                Box.GlyphType.join(x: intProm, y: intProm, type: joinType)
              }
            }
          case .trailing:
            GlyphGrid {
              Row {
                Box.GlyphType.join(x: intProm, y: intProm, type: joinType)
                Box.GlyphType.blank
                Box.GlyphType.vertical(extProm)
              }
            }

          case .top:
            GlyphGrid {
              Row {
                Box.GlyphType.horizontal(extProm)
                Box.GlyphType.blank
                Box.GlyphType.join(x: intProm, y: intProm, type: joinType)
              }
            }

          case .bottom:
            GlyphGrid {
              Row {
                Box.GlyphType.join(x: intProm, y: intProm, type: joinType)
                Box.GlyphType.blank
                Box.GlyphType.horizontal(extProm)
              }
            }

          case .cross:
            GlyphGrid {
              Row {
                Box.GlyphType.join(x: intProm, y: intProm, type: joinType)
              }
            }
        }

      case .corner(let cornerType):
        switch cornerType {
          case .topLeading:

            GlyphGrid {
              Row {
                Box.GlyphType.corner(.increased, type: cornerType)
                Box.GlyphType.horizontal(.increased)
                Box.GlyphType.horizontal(.increased)
              }
              Row {
                Box.GlyphType.vertical(.increased)
                Box.GlyphType.blank
                Box.GlyphType.corner(.standard, type: cornerType)
              }
            }

          case .topTrailing:
            GlyphGrid {
              Row {
                Box.GlyphType.corner(.increased, type: cornerType)
                Box.GlyphType.horizontal(.increased)
                Box.GlyphType.horizontal(.increased)
              }
              Row {
                Box.GlyphType.vertical(.increased)
                Box.GlyphType.blank
                Box.GlyphType.corner(.standard, type: cornerType)
              }
            }

          case .bottomLeading:
            GlyphGrid {
              Row {
                Box.GlyphType.corner(.increased, type: cornerType)
                Box.GlyphType.horizontal(.increased)
                Box.GlyphType.horizontal(.increased)
              }
              Row {
                Box.GlyphType.vertical(.increased)
                Box.GlyphType.blank
                Box.GlyphType.corner(.standard, type: cornerType)
              }
            }
          case .bottomTrailing:
            GlyphGrid {
              Row {
                Box.GlyphType.corner(.increased, type: cornerType)
                Box.GlyphType.horizontal(.increased)
                Box.GlyphType.horizontal(.increased)
              }
              Row {
                Box.GlyphType.vertical(.increased)
                Box.GlyphType.blank
                Box.GlyphType.corner(.standard, type: cornerType)
              }
            }
        }

      case .blank:
        GlyphGrid {
          Box.GlyphType.blank
        }
    }
  }  // END frame double
}
