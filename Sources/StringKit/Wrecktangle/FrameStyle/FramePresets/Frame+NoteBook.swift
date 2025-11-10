//
//  FrameNoteBook.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 5/11/2025.
//


extension Box.Frame {
//  public static let notebook = DerivedFrameStyle(
//    base: Box.FrameStyle.double,
//    overrides: [
//      .corner(.topLeading): { pos in
//        pos.isNearEdge ? Part {
//          Row { Glyph.corner(.increased, type: .topLeading) }
//        } : Part { Glyph.blank }
//      }
//    ]
//  )
}
//
//  package func notebookParts(position: Box.PositionContext) -> Part {
//    var new = self.singleFrameParts()
//    
////    if let self = case .corner(let cornerType) = self {
////      <#body#>
////    }
////    if case .corner(let cornerType) = self {
////      switch cornerType {
////        case .topLeading:
////          new.
////        case .topTrailing:
////          <#code#>
////        case .bottomLeading:
////          <#code#>
////        case .bottomTrailing:
////          <#code#>
////      }
////    }
//    
//    return new
////    switch self {
////      case .horizontal(let loc):
////        horizontal(loc)
////
////      case .vertical(let loc):
////        if position.isEven {
////          vertical(loc)
////        } else {
////          Part { Glyph.literal("?") }
////        }
////
////      case .join(let joinType):
////        join(joinType)
////
////      case .corner(let cornerType):
////        corner(cornerType)
////
////      case .blank:
////        Part { Glyph.blank }
////    }
//  }  // END frame double
//}

//extension Box.PartType {
//
//  fileprivate func horizontal(_ loc: Box.PartType.HorizontalLocation) -> Part {
//    switch loc {
//      case .top:
//        Part {
//          Row { Glyph.horizontal(.increased) }
//          Row { Glyph.horizontal(.standard) }
//
//        }
//      case .bottom:
//        Part {
//          Row { Glyph.horizontal(.standard) }
//          Row { Glyph.horizontal(.increased) }
//        }
//
//      case .interior:
//        Part {
//          Glyph.horizontal(.standard)
//        }
//    }
//  }
//}
//
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
//
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
//
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
