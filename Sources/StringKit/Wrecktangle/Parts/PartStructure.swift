//
//  PartStructure.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 10/11/2025.
//

extension Box {
  /// Needs to have nothing to do with ``Box/GlyphDesign``
  public struct PartStructure {
    let type: PartRole
    let roles: [[GlyphStructure]]

    public init(
      type: PartRole,
      roles: [[GlyphStructure]]
    ) {
      self.type = type
      self.roles = roles
    }
  }

  /// Describes enough about Structure as to be useful to
  /// Structure, but importabtly doesn't hold on to `GlyphDesign`
  /// at all, so is used for `FrameStyle`
  public struct GlyphStructure {
    let role: GlyphRole
    let weight: Box.GlyphProminence
  }
}
