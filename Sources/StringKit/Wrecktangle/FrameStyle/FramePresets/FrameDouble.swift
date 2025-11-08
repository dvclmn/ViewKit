//
//  FrameDouble.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 30/10/2025.
//

//extension Box.FrameStyle {
//  static var double: Self {
//    .init {
//      (.horizontal(.top), Part { Row { Glyph.horizontal(.increased) } })
//      (.horizontal(.bottom), Part { Row { Glyph.horizontal(.standard) } })
//      (.corner(.topLeft), Part { Row { Glyph.corner(.rounded) } })
//    }
//  }
//}

extension Box.FrameStyle {
  public static var double: Self {
    Frame {
      // MARK: - Horizontal
      Part(.horizontal(.top)) {
        Row { Glyph.horizontal(.increased) }
        Row { Glyph.horizontal(.standard) }

      }
      Part(.horizontal(.bottom)) {
        Row { Glyph.horizontal(.standard) }
        Row { Glyph.horizontal(.increased) }
      }
      Part(.horizontal(.interior)) {
        Glyph.horizontal(.standard)
      }
//
//      // MARK: - Horizontal
      Part(.vertical(.leading)) {
        Row {
          Glyph.vertical(.increased)
          Glyph.blank
          Glyph.vertical(.standard)
        }
      }
      Part(.vertical(.trailing)) {
        Row {
          Glyph.vertical(.standard)
          Glyph.blank
          Glyph.vertical(.increased)
        }
      }
      Part(.vertical(.interior)) {
        Glyph.vertical(.standard)
      }

      Part(.join(.leading)) {
        Row {
          Glyph.vertical(.increased)
          Glyph.blank
          Glyph.join(x: .standard, y: .increased, type: .leading)
//          Glyph.join(x: .standard, y: .standard, type: type)
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

//extension Box.PartType {
//
//  package func doubleFrameParts() -> Part {
//    switch self {
//      case .horizontal(let loc): horizontal(loc)
//      case .vertical(let loc): vertical(loc)
//      case .join(let joinType): join(joinType)
//      case .corner(let cornerType): corner(cornerType)
//      case .blank: Part(.blank) { Glyph.blank }
//    }
//  }
//}

//extension Box.PartType {
//
//  fileprivate func horizontal(_ loc: Box.PartType.HorizontalLocation) -> Part {
//    switch loc {
//      case .top:
//      case .bottom:
//
//
//      case .interior:
//    }
//  }
//}

//extension Box.PartType {
//
//  fileprivate func vertical(_ loc: Box.PartType.VerticalLocation) -> Part {
//    switch loc {
//      case .leading:
//        Part {
//          Row {
//            Glyph.vertical(.increased)
//            Glyph.blank
//            Glyph.vertical(.standard)
//          }
//        }
//      case .trailing:
//        Part {
//          Row {
//            Glyph.vertical(.standard)
//            Glyph.blank
//            Glyph.vertical(.increased)
//          }
//        }
//      case .interior:
//        Part {
//          Glyph.vertical(.standard)
//        }
//    }
//  }
//}

//extension Box.PartType {
//
//  fileprivate func join(_ type: Box.JoinType) -> Part {
//    switch type {
//      case .leading:
//        Part {
//          Row {
//            Glyph.vertical(.increased)
//            Glyph.blank
//            Glyph.join(x: .standard, y: .standard, type: type)
//          }
//        }
//      case .trailing:
//        Part {
//          Row {
//            Glyph.join(x: .standard, y: .standard, type: type)
//            Glyph.blank
//            Glyph.vertical(.increased)
//          }
//        }
//
//      case .top:
//        Part {
//          Row {
//            Glyph.horizontal(.increased)
//            Glyph.blank
//            Glyph.join(x: .standard, y: .standard, type: type)
//          }
//        }
//
//      case .bottom:
//        Part {
//          Row {
//            Glyph.join(x: .standard, y: .standard, type: type)
//            Glyph.blank
//            Glyph.horizontal(.increased)
//          }
//        }
//
//      case .cross:
//        Part {
//          Row {
//            Glyph.join(x: .standard, y: .standard, type: type)
//          }
//        }
//    }
//
//  }
//}

//extension Box.PartType {
//  fileprivate func corner(_ type: Box.CornerType) -> Part {
//    switch type {
//      case .topLeading:
//
//        Part {
//          Row {
//            Glyph.corner(.increased, type: type)
//            Glyph.horizontal(.increased)
//            Glyph.horizontal(.increased)
//          }
//          Row {
//            Glyph.vertical(.increased)
//            Glyph.blank
//            Glyph.corner(.standard, type: type)
//          }
//        }
//
//      case .topTrailing:
//        Part {
//          Row {
//            Glyph.horizontal(.increased)
//            Glyph.horizontal(.increased)
//            Glyph.corner(.increased, type: type)
//          }
//          Row {
//            Glyph.corner(.standard, type: type)
//            Glyph.blank
//            Glyph.vertical(.increased)
//          }
//        }
//
//      case .bottomLeading:
//        Part {
//          Row {
//            Glyph.vertical(.increased)
//            Glyph.blank
//            Glyph.corner(.standard, type: type)
//          }
//
//          Row {
//            Glyph.corner(.increased, type: type)
//            Glyph.horizontal(.increased)
//            Glyph.horizontal(.increased)
//          }
//        }
//
//      case .bottomTrailing:
//        Part {
//          Row {
//            Glyph.corner(.standard, type: type)
//            Glyph.blank
//            Glyph.vertical(.increased)
//          }
//
//          Row {
//            Glyph.horizontal(.increased)
//            Glyph.horizontal(.increased)
//            Glyph.corner(.increased, type: type)
//          }
//        }
//    }
//
//  }
//}
