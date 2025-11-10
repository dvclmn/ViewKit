//
//  GlyphSet.swift
//  BoxCore
//
//  Created by Dave Coleman on 12/9/2024.
//

extension Box {
  public typealias GlyphMap = [GlyphType: Character]
}

public typealias GlyphSet = Box.GlyphSet

extension Box {

  public struct GlyphSet: Codable, Equatable, Sendable {
//    public var design: GlyphType.Design
    public var map: GlyphMap
    public var fallback: GlyphSetReference?

    public init(
//      _ design: GlyphType.Design,
      fallback: Self? = nil,
      @GlyphSetBuilder _ map: () -> GlyphMap,
    ) {
//      self.design = design
      if let fallback {
        self.fallback = SetRef(fallback)
      } else {
        self.fallback = nil
      }
      self.map = map()
//      self.map = GlyphDesignContext.$currentDesign.withValue(design) { map() }
    }

    public init(
//      design: GlyphType.Design,
      map: GlyphMap,
      fallback: GlyphSetReference? = nil
    ) {
//      self.design = design
      self.map = map
      self.fallback = fallback
    }
  }
}

extension Box.GlyphSet {
  public func resolve(
    _ desc: Box.GlyphType
  ) -> Character {
    map[desc] ?? fallback?.wrapped.resolve(desc) ?? "🫥"
  }
}

enum GlyphDesignContext {
  @TaskLocal static var currentDesign: Box.GlyphType.Design?
}
