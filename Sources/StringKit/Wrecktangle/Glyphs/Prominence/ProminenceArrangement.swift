//
//  ProminenceArrangement.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 2/11/2025.
//

import Foundation

public typealias Prominence = Box.GlyphProminence

extension Box {
  /// Note: This is only required for a FrameStyle of `double` (or more).
  /// Single just takes a single `Prominence`.
  public enum ProminenceArrangement {
    case uniform(Prominence)
    case lightInteriorStrongExterior
  }
}

extension Box.ProminenceArrangement {

  /// Returns an ordered list of Prominences, from which the caller
  /// can extract what they need.
  ///
  /// This correlates directly with the Frame Style's glyph count;
  /// single, double, etc. Only supporting up to two for now.
  func doubleFrameGlyphProminence(for partType: Box.PartType) -> (Prominence, Prominence)? {
    //  func prominence(for partType: Box.PartType) -> (x: Prominence, y: Prominence) {
    switch self {
      case .single(let prom):
        /// Both the same
        (prom, prom)

      case .lightInteriorStrongExterior:

        switch partType {
          case .horizontal(let location):
            switch location {
              case .top: (.strong, .light)
              case .bottom: (.light, .strong)
              case .interior: (.light, .light)
            }

          case .vertical(let location):
            switch location {
              case .leading: (.strong, .light)
              case .trailing: (.light, .strong)
              case .interior: (.light, .light)
            }

          case .join(let joinType):
            switch joinType {
              case .leading, .top:
                (.strong, .light)
              case .trailing, .bottom:
                (.light, .strong)

              /// Blegh not sure what to do for cross, for this?
              case .cross:
                (.strong, .strong)
            }

          case .corner(let cornerType):
            switch cornerType {
              case .topLeading, .bottomLeading:
                (.strong, .light)

              case .topTrailing, .bottomTrailing:
                (.light, .strong)
            }
          case .text, .blank:
            nil

        }

    //      case .custom(let x, let y):
    }
  }

  //  func glyphType(for partType: Box.PartType) -> Box.GlyphType {
  //
  //    switch self {
  //      case .single(let glyphProminence):
  //        <#code#>
  //      case .lightInteriorStrongExterior:
  //        <#code#>
  //      case .custom(let x, let y):
  //        <#code#>
  //    }
  //  }
}
