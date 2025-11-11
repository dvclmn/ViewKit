//
//  PartStructure.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 10/11/2025.
//

extension Box {
  /// Needs to have nothing to do with ``Box/GlyphDesign``
  public struct PartStructure: Sendable, Equatable, Codable, Hashable {
    /// What bit of the Box does this Part build
    let type: PartRole
    
    /// What glyphs are used to compose this Part
    let glyphs: [[GlyphStructure]]

    public init(
      type: PartRole,
      glyphs: [[GlyphStructure]]
    ) {
      self.type = type
      self.glyphs = glyphs
    }
  }

  /// Describes enough about Structure as to be useful to
  /// Structure, but importabtly doesn't hold on to `GlyphDesign`
  /// at all, so is used for `FrameStyle`
  public struct GlyphStructure: Sendable, Codable, Hashable {
    let role: GlyphRole
    let weight: Box.GlyphWeight
    
    public init(_ role: GlyphRole, weight: Box.GlyphWeight) {
      self.role = role
      self.weight = weight
    }
  }
}

extension Box.PartStructure {
  
  var width: Int { glyphs.width(for: .widestRow) }
  
  static var blank: Box.PartResolved {
    .init(type: .blank, glyphs: [])
  }
}
