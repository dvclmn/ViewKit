//
//  GlyphSet.swift
//  BoxCore
//
//  Created by Dave Coleman on 12/9/2024.
//

public typealias SetRef = Box.GlyphSetReference
public typealias GlyphSet = Box.GlyphSet
extension Box {
  public typealias GlyphMap = [GlyphDescriptor: Character]
}

extension Box {

  public struct GlyphSet: Codable, Equatable, Sendable {
    public var style: GlyphDescriptor.Design
    public var map: GlyphMap
    public var fallback: GlyphSetReference?

    public init(
      _ style: GlyphDescriptor.Design,
      fallback: Self? = nil,
      //      fallback: GlyphSetReference? = nil,
      @GlyphSetBuilder _ map: () -> GlyphMap,

      //      map: GlyphMap,
      //      fallback: GlyphSetReference? = nil
    ) {
      self.style = style
      if let fallback {
        self.fallback = SetRef(fallback)
      } else {
        self.fallback = nil
      }
      self.map = map()
    }

    public init(
      style: GlyphDescriptor.Design,
      map: GlyphMap,
      fallback: GlyphSetReference? = nil
    ) {
      self.style = style
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
//
//  /// A `GlyphSet` can either be a `base` set, or a `partial`set.
//  ///
//  /// A `base` set represents the 'most exhaustive' list of Glyphs, for describing
//  /// an ASCII box drawing.
//  ///
//  /// A `partial` set can then build upon this foundation, specifying
//  /// which `base` set to fall back on, for un-specified glyphs
//  public enum GlyphSet: Sendable, Codable, Equatable {
//
//    case base(GlyphMap)
//
//    /// `indirect` because we need to specify the set
//    /// to fall back on, for partial sets
//    indirect case partial(GlyphMap, GlyphSet)
//  }
//}
