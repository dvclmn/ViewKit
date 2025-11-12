//
//  GlyphSet.swift
//  BoxCore
//
//  Created by Dave Coleman on 12/9/2024.
//

extension Box {
  public typealias GlyphMap = [GlyphDescriptor: Character]
}

public typealias GlyphSet = Box.GlyphSet

extension Box {

  public struct GlyphSet: Codable, Equatable, Sendable {

    /// This needs to be defined here, to allow the child
    /// `Glyph`s to have their `design` properties set
    /// *once*, rather than requiring each to set it per-Glyph.
    public var design: GlyphDesign
    public var glyphs: GlyphMap

    public init(
      _ design: GlyphDesign,
      @GlyphSetBuilder _ glyphs: () -> GlyphMap,
    ) {
      self.design = design
      self.glyphs = GlyphDesignContext.$currentDesign.withValue(design) { glyphs() }
    }

    public init(
      design: GlyphDesign,
      map: GlyphMap,
    ) {
      self.design = design
      self.glyphs = map
    }
  }
}

extension Box.GlyphSet {
  public func resolve(_ desc: Box.GlyphDescriptor) -> Character {
//    "8"
    glyphs[desc] ?? Box.glyphSetCharacterFallback
  }
}

enum GlyphDesignContext {
  @TaskLocal static var currentDesign: Box.GlyphDesign?
}
