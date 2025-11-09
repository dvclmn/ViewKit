//
//  GlyphSet.swift
//  BoxCore
//
//  Created by Dave Coleman on 12/9/2024.
//

public typealias SetRef = Box.GlyphSetReference
extension Box {
  public typealias GlyphMap = [GlyphDescriptor: Character]
}

extension Box {

  public struct GlyphSet: Codable, Equatable {
    public var style: GlyphDescriptor.Style
    public var map: GlyphMap
    public var fallback: GlyphSetReference?

    public init(
      style: GlyphDescriptor.Style,
      map: GlyphMap,
      fallback: GlyphSetReference? = nil
    ) {
      self.style = style
      self.map = map
      self.fallback = fallback
    }
  }

  public final class GlyphSetReference: Codable {
    public var wrapped: GlyphSet
    public init(_ wrapped: GlyphSet) { self.wrapped = wrapped }
  }

}

extension Box.GlyphSetReference: Equatable {
  public static func == (lhs: Box.GlyphSetReference, rhs: Box.GlyphSetReference) -> Bool {
    lhs.wrapped == rhs.wrapped
  }
}

extension Box.GlyphSet {
  public func resolve(
    _ desc: Box.GlyphDescriptor
  ) -> Character {
    map[desc] ?? fallback?.wrapped.resolve(desc) ?? "🫥"
  }
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
