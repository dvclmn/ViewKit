//
//  LineType+Structure.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 31/10/2025.
//

import Foundation

//public protocol BoxLine {
//  var leading: Box.PartType { get }
//  var repeating: Box.PartType { get }
//  var trailing: Box.PartType { get }
//}

//public struct Structure: BoxLine {
//
//}

extension Box.Line {

  /// What kinds of lines could there be, in a box?
  ///
  /// Note: These, by definition, describe a *whole* line, stretching
  /// from one end to the other. Not just a sub-component.
  ///
  /// E.g. `top` would consist of a leading cap, repeating part, and trailing cap.
  public enum StructureType: Hashable, Sendable {
    case top
    case divider
    case bottom
    /// This should generate spaces for the full width
    //    case blank  // `spacer` a better name?

    public var parts: ThreePartLine {
      switch self {
        case .top:
          (
            Box.PartType.corner(.topLeading),
            Box.PartType.horizontal(.top),
            Box.PartType.corner(.topTrailing)
          )

        case .divider:
          (
            Box.PartType.join(.leading),
            Box.PartType.horizontal(.interior),
            Box.PartType.join(.trailing)
          )

        case .bottom:
          (
            Box.PartType.corner(.bottomLeading),
            Box.PartType.horizontal(.bottom),
            Box.PartType.corner(.bottomTrailing)
          )

      //        case .blank:
      //          (
      //            Box.PartType.blank,
      ////            Box.PartType.vertical(.interior),
      //            Box.PartType.blank,
      //            Box.PartType.blank
      ////            Box.PartType.vertical(.interior)
      //          )
      //        case .text:
      //          nil
      }
    }  // END parts
  }
}
