//
//  PartStructure.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 10/11/2025.
//

public typealias Part = Box.PartStructure

extension Box {
  /// Needs to have nothing to do with ``Box/GlyphDesign``
  public struct PartStructure: Sendable, Equatable, Codable, Hashable {
    /// What bit of the Box does this Part build
    let role: PartRole
    
    /// What glyphs are used to compose this Part
    let glyphs: [[GlyphStructure]]

    public init(
      _ role: PartRole,
      glyphs: [[GlyphStructure]]
    ) {
      self.role = role
      self.glyphs = glyphs
    }
  }

}

extension Box.PartStructure {
  
  var width: Int { glyphs.width(for: .widestRow) }
  
  static var blank: Box.PartResolved {
    .init(type: .blank, glyphs: [])
  }
}
