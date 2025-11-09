//
//  GlyphSet.swift
//  BoxCore
//
//  Created by Dave Coleman on 12/9/2024.
//

public typealias GlyphSet = Box.GlyphSet
extension Box {
  public typealias GlyphMap = [GlyphDescriptor: Character]
}

extension Box {

  public struct GlyphSet: Codable, Equatable, Sendable {
    public var design: GlyphDescriptor.Design
    public var map: GlyphMap
    public var fallback: GlyphSetReference?

    public init(
      _ design: GlyphDescriptor.Design,
      fallback: Self? = nil,
      @GlyphSetBuilder _ map: () -> GlyphMap,
    ) {
      self.design = design
      if let fallback {
        self.fallback = SetRef(fallback)
      } else {
        self.fallback = nil
      }
      self.map = GlyphDesignContext.$currentDesign.withValue(design) { map() }

    }

    public init(
      design: GlyphDescriptor.Design,
      map: GlyphMap,
      fallback: GlyphSetReference? = nil
    ) {
      self.design = design
      self.map = map
      self.fallback = fallback
    }
  }
}

extension Box.GlyphSet {
  public func resolve(
    _ desc: Box.GlyphDescriptor
  ) -> Character {
    map[desc] ?? fallback?.wrapped.resolve(desc) ?? "🫥"
  }
}

enum GlyphDesignContext {
  @TaskLocal static var currentDesign: Box.GlyphDescriptor.Design?
}
