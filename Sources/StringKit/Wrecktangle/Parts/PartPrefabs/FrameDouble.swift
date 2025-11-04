//
//  FrameDouble.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 30/10/2025.
//

extension Box.PartType {
  public typealias Glyph = Box.GlyphType

  /// `Prominence.increased` on the external frame parts,
  /// and  `Prominence.standard` on the internal parts
  package func doubleFrameParts(
    extProm: Box.GlyphProminence,
    intProm: Box.GlyphProminence,
  ) -> Box.GlyphStack {

    switch self {
      case .horizontal(let loc):
        switch loc {
          case .top:
            GlyphGrid {
              Row { Glyph.horizontal(extProm) }
              Row { Glyph.blank }
              Row { Glyph.horizontal(intProm) }

            }
          case .bottom:
            GlyphGrid {
              Row { Glyph.horizontal(intProm) }
              Row { Glyph.blank }
              Row { Glyph.horizontal(extProm) }
            }

          case .interior:
            GlyphGrid { Glyph.horizontal(intProm) }
        }

      case .vertical(let loc):
        switch loc {
          case .leading:
            GlyphGrid {
              Row {
                Glyph.vertical(extProm)
                Glyph.blank
                Glyph.vertical(intProm)
              }
            }
          case .trailing:
            GlyphGrid {
              Row {
                Glyph.vertical(intProm)
                Glyph.blank
                Glyph.vertical(extProm)
              }
            }
          case .interior:
            GlyphGrid {
              Glyph.vertical(intProm)
            }
        }

      case .join(let joinType):
        switch joinType {
          case .leading:
            GlyphGrid {
              Row {
                Glyph.vertical(extProm)
                Glyph.blank
                Glyph.join(x: intProm, y: intProm, type: joinType)
              }
            }
          case .trailing:
            GlyphGrid {
              Row {
                Glyph.join(x: intProm, y: intProm, type: joinType)
                Glyph.blank
                Glyph.vertical(extProm)
              }
            }

          case .top:
            GlyphGrid {
              Row {
                Glyph.horizontal(extProm)
                Glyph.blank
                Glyph.join(x: intProm, y: intProm, type: joinType)
              }
            }

          case .bottom:
            GlyphGrid {
              Row {
                Glyph.join(x: intProm, y: intProm, type: joinType)
                Glyph.blank
                Glyph.horizontal(extProm)
              }
            }

          case .cross:
            GlyphGrid {
              Row {
                Glyph.join(x: intProm, y: intProm, type: joinType)
              }
            }
        }

      case .corner(let cornerType):
        switch cornerType {
          case .topLeading:

            GlyphGrid {
              Row {
                Glyph.corner(.increased, type: cornerType)
                Glyph.horizontal(.increased)
                Glyph.horizontal(.increased)
              }
              Row {
                Glyph.vertical(.increased)
                Glyph.blank
                Glyph.corner(.standard, type: cornerType)
              }
            }

          case .topTrailing:
            GlyphGrid {
              Row {
                Glyph.corner(.increased, type: cornerType)
                Glyph.horizontal(.increased)
                Glyph.horizontal(.increased)
              }
              Row {
                Glyph.vertical(.increased)
                Glyph.blank
                Glyph.corner(.standard, type: cornerType)
              }
            }

          case .bottomLeading:
            GlyphGrid {
              Row {
                Glyph.corner(.increased, type: cornerType)
                Glyph.horizontal(.increased)
                Glyph.horizontal(.increased)
              }
              Row {
                Glyph.vertical(.increased)
                Glyph.blank
                Glyph.corner(.standard, type: cornerType)
              }
            }
          case .bottomTrailing:
            GlyphGrid {
              Row {
                Glyph.corner(.increased, type: cornerType)
                Glyph.horizontal(.increased)
                Glyph.horizontal(.increased)
              }
              Row {
                Glyph.vertical(.increased)
                Glyph.blank
                Glyph.corner(.standard, type: cornerType)
              }
            }
        }

      case .blank:
        GlyphGrid {
          Glyph.blank
        }
    }
  }  // END frame double
}
