//
//  GlyphType+AllCases.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 31/10/2025.
//

extension Box.GlyphType: CaseIterable {

  /// Originally made for exhaustiveness checking, for Base GlyphSets
  public static let allCases: [Box.GlyphType] = [
    .horizontal(.interior),
    .horizontal(.exterior),

    .vertical(.interior),
    .vertical(.exterior),

    .join(x: .interior, y: .interior, type: .leading),
    .join(x: .exterior, y: .interior, type: .leading),
    .join(x: .interior, y: .exterior, type: .leading),
    .join(x: .exterior, y: .exterior, type: .leading),

    .join(x: .interior, y: .interior, type: .trailing),
    .join(x: .exterior, y: .interior, type: .trailing),
    .join(x: .interior, y: .exterior, type: .trailing),
    .join(x: .exterior, y: .exterior, type: .trailing),

    .join(x: .interior, y: .interior, type: .top),
    .join(x: .exterior, y: .interior, type: .top),
    .join(x: .interior, y: .exterior, type: .top),
    .join(x: .exterior, y: .exterior, type: .top),

    .join(x: .interior, y: .interior, type: .bottom),
    .join(x: .exterior, y: .interior, type: .bottom),
    .join(x: .interior, y: .exterior, type: .bottom),
    .join(x: .exterior, y: .exterior, type: .bottom),

    .join(x: .interior, y: .interior, type: .cross),
    .join(x: .exterior, y: .interior, type: .cross),
    .join(x: .interior, y: .exterior, type: .cross),
    .join(x: .exterior, y: .exterior, type: .cross),

    .corner(location: .interior, type: .topLeading),
    .corner(location: .exterior, type: .topLeading),

    .corner(location: .interior, type: .topTrailing),
    .corner(location: .exterior, type: .topTrailing),

    .corner(location: .interior, type: .bottomLeading),
    .corner(location: .exterior, type: .bottomLeading),

    .corner(location: .interior, type: .bottomTrailing),
    .corner(location: .exterior, type: .bottomTrailing),

  ]

}

//public enum GlyphList {
//  case horizontalInterior
//  case horizontalExterior
//  
//  case verticalInterior
//  case verticalExterior
//  
//  case joinInteriorXInteriorYLeading
//  case joinExteriorXInteriorYLeading
//}
