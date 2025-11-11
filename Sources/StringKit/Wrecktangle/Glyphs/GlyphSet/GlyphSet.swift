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
    public var fallback: GlyphSetReference?

    public init(
      _ design: GlyphDesign,
      fallback: Self? = nil,
      @GlyphSetBuilder _ glyphs: () -> GlyphMap,
    ) {
      self.design = design
      if let fallback {
        self.fallback = SetRef(fallback)
      } else {
        self.fallback = nil
      }
      self.glyphs = GlyphDesignContext.$currentDesign.withValue(design) { glyphs() }
    }

    public init(
      design: GlyphDesign,
      map: GlyphMap,
      fallback: GlyphSetReference? = nil
    ) {
      self.design = design
      self.glyphs = map
      self.fallback = fallback
    }
  }
}

extension Box.GlyphSet {
  public func resolve(
    _ desc: Box.GlyphDescriptor
  ) -> Character {
    glyphs[desc] ?? fallback?.wrapped.resolve(desc) ?? "🫥"
  }
}

enum GlyphDesignContext {
  @TaskLocal static var currentDesign: Box.GlyphDesign?
}
