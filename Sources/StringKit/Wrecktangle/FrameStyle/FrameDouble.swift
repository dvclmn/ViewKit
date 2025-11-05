//
//  FrameDouble.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 30/10/2025.
//

extension Box.PartType {

  /// `Prominence.increased` on the external frame parts,
  /// and  `Prominence.standard` on the internal parts
  package func doubleFrameParts() -> Part {
    //  ) -> Box.GlyphStack {

    switch self {

      case .horizontal(let loc):
        switch loc {
          case .top:
            Part {
              Row { Glyph.horizontal(.increased) }
              Row { Glyph.horizontal(.standard) }

            }
          case .bottom:
            Part {
              Row { Glyph.horizontal(.standard) }
              Row { Glyph.horizontal(.increased) }
            }

          case .interior:
            Part {
              Glyph.horizontal(.standard)
            }
        }

      case .vertical(let loc):
        switch loc {
          case .leading:
            Part {
              Row {
                Glyph.vertical(.increased)
                Glyph.blank
                Glyph.vertical(.standard)
              }
            }
          case .trailing:
            Part {
              Row {
                Glyph.vertical(.standard)
                Glyph.blank
                Glyph.vertical(.increased)
              }
            }
          case .interior:
            Part {
              Glyph.vertical(.standard)
            }
        }

      case .join(let joinType):
        switch joinType {
          case .leading:
            Part {
              Row {
                Glyph.vertical(.increased)
                Glyph.blank
                Glyph.join(x: .standard, y: .standard, type: joinType)
              }
            }
          case .trailing:
            Part {
              Row {
                Glyph.join(x: .standard, y: .standard, type: joinType)
                Glyph.blank
                Glyph.vertical(.increased)
              }
            }

          case .top:
            Part {
              Row {
                Glyph.horizontal(.increased)
                Glyph.blank
                Glyph.join(x: .standard, y: .standard, type: joinType)
              }
            }

          case .bottom:
            Part {
              Row {
                Glyph.join(x: .standard, y: .standard, type: joinType)
                Glyph.blank
                Glyph.horizontal(.increased)
              }
            }

          case .cross:
            Part {
              Row {
                Glyph.join(x: .standard, y: .standard, type: joinType)
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
