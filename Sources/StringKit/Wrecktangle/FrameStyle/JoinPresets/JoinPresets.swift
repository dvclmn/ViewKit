//
//  JoinPresets.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 8/11/2025.
//

extension Box.JoinType {
  static var doubleJoin: Frame {
    Frame {
      Part(.join(.leading)) {
        Row {
          Glyph.vertical(.increased)
          Glyph.blank
          Glyph.join(x: .standard, y: .increased, type: .leading)
        }
      }

      Part(.join(.trailing)) {
        Row {
          Glyph.join(x: .standard, y: .standard, type: .trailing)
          Glyph.blank
          Glyph.vertical(.increased)
        }
      }

      Part(.join(.top)) {
        Row {
          Glyph.horizontal(.increased)
          Glyph.blank
          Glyph.join(x: .standard, y: .standard, type: .top)
        }
      }

      Part(.join(.bottom)) {
        Row {
          Glyph.join(x: .standard, y: .standard, type: .bottom)
          Glyph.blank
          Glyph.horizontal(.increased)
        }
      }

      Part(.join(.cross)) {
        Row {
          Glyph.join(x: .standard, y: .standard, type: .cross)
        }
      }
    }
  }
}

extension Box.CornerType {
  static var doubleCorner: Frame {
    Frame {
      // MARK: - Corner
      
      Part(.corner(.topLeading)) {
        Row {
          Glyph.corner(.increased, type: .topLeading)
          Glyph.horizontal(.increased)
          Glyph.horizontal(.increased)
        }
        Row {
          Glyph.vertical(.increased)
          Glyph.blank
          Glyph.corner(.standard, type: .topLeading)
        }
      }
      
      Part(.corner(.topTrailing)) {
        Row {
          Glyph.horizontal(.increased)
          Glyph.horizontal(.increased)
          Glyph.corner(.increased, type: .topTrailing)
        }
        Row {
          Glyph.corner(.standard, type: .topTrailing)
          Glyph.blank
          Glyph.vertical(.increased)
        }
      }
      
      Part(.corner(.bottomLeading)) {
        Row {
          Glyph.vertical(.increased)
          Glyph.blank
          Glyph.corner(.standard, type: .bottomLeading)
        }
        
        Row {
          Glyph.corner(.increased, type: .bottomLeading)
          Glyph.horizontal(.increased)
          Glyph.horizontal(.increased)
        }
      }
      
      Part(.corner(.bottomTrailing)) {
        Row {
          Glyph.corner(.standard, type: .bottomTrailing)
          Glyph.blank
          Glyph.vertical(.increased)
        }
        
        Row {
          Glyph.horizontal(.increased)
          Glyph.horizontal(.increased)
          Glyph.corner(.increased, type: .bottomTrailing)
        }
      }
    }
  }
}
