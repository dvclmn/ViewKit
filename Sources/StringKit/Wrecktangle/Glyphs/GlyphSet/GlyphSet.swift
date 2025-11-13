//
//  GlyphSet.swift
//  BoxCore
//
//  Created by Dave Coleman on 12/9/2024.
//

extension Box {
  public typealias GlyphMap = [GlyphKey: Glyph]
//  public typealias GlyphMap = [GlyphKey: GlyphDesign]

  //  public typealias GlyphMap = [GlyphDescriptor: Character]
}

public typealias GlyphSet = Box.GlyphSet

extension Box {

  public struct GlyphSet: Codable, Equatable, Sendable {

    /// This needs to be defined here, to allow the child
    /// `Glyph`s to have their `design` properties set
    /// *once*, rather than requiring each to set it per-Glyph.
    //    public var design: GlyphDesign
    //    public var glyphs: GlyphMap

    public let design: GlyphDesign
    let glyphMap: GlyphMap

    public init(
      _ design: GlyphDesign,
      @GlyphSetBuilder _ glyphs: () -> GlyphMap,
    ) {
      self.design = design
      self.glyphMap = GlyphDesignContext.$currentDesign.withValue(design) { glyphs() }
    }

    public init(
      design: GlyphDesign,
      map: GlyphMap,
    ) {
      self.design = design
      self.glyphMap = map
    }
  }
}

extension Box.GlyphSet {

  /// Resolve a GlyphDescriptor to a Character
  func character(for descriptor: Box.GlyphDescriptor) -> Character {
    /// lookup by role + weight from the descriptor's structure
    /// fallback to design if needed
    let key = Box.GlyphKey(
      role: descriptor.structure.role,
      weight: descriptor.structure.weight
    )
//    return glyphMap[key]?.name ?? Box.glyphSetCharacterFallback
    return glyphMap[key]?.character ?? Box.glyphSetCharacterFallback
  }

  /// Lookup: given a structural role + weight, returns the design for this set
//  public func design(
//    for role: Box.GlyphRole,
//    weight: Box.GlyphWeight
//  ) -> Box.GlyphDesign {
//    let key = Box.GlyphKey(role: role, weight: weight)
//    return glyphMap[key] ?? Box.GlyphDesign.default
//    //    return glyphMap[key] ?? Box.GlyphDesign.defaultDesign(for: role)
//  }

  //  public func resolve(_ desc: Box.GlyphDescriptor) -> Character {
  ////    "8"
  //    glyphs[desc] ?? Box.glyphSetCharacterFallback
  //  }
}

enum GlyphDesignContext {
  @TaskLocal static var currentDesign: Box.GlyphDesign?
}
