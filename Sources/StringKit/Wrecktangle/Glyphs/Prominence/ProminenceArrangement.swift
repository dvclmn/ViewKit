//
//  ProminenceArrangement.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 2/11/2025.
//

import Foundation

public typealias Prominence = Box.GlyphProminence

extension Box {
  public enum ProminenceArrangement {
    case single(Prominence)
    case lightInteriorStrongExterior
//    case custom(x: Prominence, y: Prominence)
  }
}

extension Box.ProminenceArrangement {
  
  /// Returns an ordered list of Prominences, from which the caller
  /// can extract what they need.
  ///
  /// This correlates directly with the Frame Style's glyph count;
  /// single, double, etc. Only supporting up to two for now.
  func prominence(for partType: Box.PartType) -> [Prominence] {
//  func prominence(for partType: Box.PartType) -> (x: Prominence, y: Prominence) {
    switch self {
      case .single(let prom):
        /// Both the same
        [prom, prom]
        
      case .lightInteriorStrongExterior:
        
        switch partType {
          case .horizontal(let location):
            switch location {
              case .top: [.strong, .light]
              case .bottom: [.light, .strong]
              case .interior: [.light, .light]
            }
            
          case .vertical(let location):
            switch location {
              case .leading: [.strong, .light]
              case .trailing: [.light, .strong]
              case .interior: [.light, .light]
            }
            
            // ┤ ║
          case .join(let joinType):
            switch joinType {
              case .leading:
                <#code#>
              case .trailing:
                <#code#>
              case .top:
                <#code#>
              case .bottom:
                <#code#>
              case .cross:
                <#code#>
            }
            
          case .corner(let cornerType):
            <#code#>
          case .text(let string):
            <#code#>
          case .blank:
            <#code#>
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

