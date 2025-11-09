//
//  ComponentTypes.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 9/11/2025.
//

/// E.g. `Part`, `Line`
protocol StructuralType {
  associatedtype Key: Hashable
}

/// E.g. `FrameStyle`, `GlyphSet`
protocol DesignMap {
  associatedtype Key: Hashable
  associatedtype Value
  var map: [Key: Value] { get set }
}
