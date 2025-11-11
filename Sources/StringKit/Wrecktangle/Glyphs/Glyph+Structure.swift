//
//  Glyph+Structure.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 11/11/2025.
//

/// For Frame builders
public typealias GlyphType = Box.GlyphStructure

/// For GlyphSet builders
public typealias Glyph = Box.GlyphResolved
//public typealias Glyph = Box.GlyphDescriptor

extension Box {

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
