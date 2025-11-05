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
  ) -> Part {
    //  ) -> Box.GlyphStack {

    switch self {

      case .horizontal(let loc):
        switch loc {
          case .top:
            Part {
              Row { Glyph.horizontal(extProm) }
              Row { Glyph.horizontal(intProm) }

            }
          case .bottom:
            Part {
              Row { Glyph.horizontal(intProm) }
              Row { Glyph.horizontal(extProm) }
            }

          case .interior:
            Part {
              Glyph.horizontal(intProm)
            }
        }

      case .vertical(let loc):
        switch loc {
          case .leading:
            Part {
              Row {
                Glyph.vertical(extProm)
                Glyph.blank
                Glyph.vertical(intProm)
              }
            }
          case .trailing:
            Part {
              Row {
                Glyph.vertical(intProm)
                Glyph.blank
                Glyph.vertical(extProm)
              }
            }
          case .interior:
            Part {
              Glyph.vertical(intProm)
            }
        }

      case .join(let joinType):
        switch joinType {
          case .leading:
            Part {
              Row {
                Glyph.vertical(extProm)
                Glyph.blank
                Glyph.join(x: intProm, y: intProm, type: joinType)
              }
            }
          case .trailing:
            Part {
              Row {
                Glyph.join(x: intProm, y: intProm, type: joinType)
                Glyph.blank
                Glyph.vertical(extProm)
              }
            }

          case .top:
            Part {
              Row {
                Glyph.horizontal(extProm)
                Glyph.blank
                Glyph.join(x: intProm, y: intProm, type: joinType)
              }
            }

          case .bottom:
            Part {
              Row {
                Glyph.join(x: intProm, y: intProm, type: joinType)
                Glyph.blank
                Glyph.horizontal(extProm)
              }
            }

          case .cross:
            Part {
              Row {
                Glyph.join(x: intProm, y: intProm, type: joinType)
              }
            }
        }

      case .corner(let cornerType):
        switch cornerType {
          case .topLeading:

            Part {
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
            Part {
              Row {
                Glyph.horizontal(.increased)
                Glyph.horizontal(.increased)
                Glyph.corner(.increased, type: cornerType)
              }
              Row {
                Glyph.corner(.standard, type: cornerType)
                Glyph.blank
                Glyph.vertical(.increased)
              }
            }

          case .bottomLeading:
            Part {
              Row {
                Glyph.vertical(.increased)
                Glyph.blank
                Glyph.corner(.standard, type: cornerType)
              }

              Row {
                Glyph.corner(.increased, type: cornerType)
                Glyph.horizontal(.increased)
                Glyph.horizontal(.increased)
              }
            }

          case .bottomTrailing:
            Part {
              Row {
                Glyph.corner(.standard, type: cornerType)
                Glyph.blank
                Glyph.vertical(.increased)
              }

              Row {
                Glyph.horizontal(.increased)
                Glyph.horizontal(.increased)
                Glyph.corner(.increased, type: cornerType)
              }
            }
        }

      case .blank:
        Part {
          Glyph.blank
        }
    }
  }  // END frame double
}
