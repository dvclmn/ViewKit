//
//  DesignResolved.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 13/11/2025.
//

/// Represents a structure that has been paired with a design
protocol DesignResolved {
  associatedtype Structure
  associatedtype Design

  var structure: Structure { get }
  var design: Design { get }
}

extension Box {
  struct Resolver {
    let designSet: GlyphSet

    func resolve(structure: GlyphStructure) -> GlyphDescriptor {
      GlyphDescriptor(
        structure,
        design: designSet.design(for: structure.role, weight: structure.weight)
      )
    }
  }
}

extension Part {
  func map<U>(_ transform: (GlyphKind) -> U) -> Part<U> {
    Part<U>(role: role, glyphs: glyphs.map { $0.map(transform) })
  }
}

extension Part where GlyphKind == Box.GlyphStructure {
  func resolved(using resolver: Box.Resolver) -> Part<Box.GlyphDescriptor> {
    Part<Box.GlyphDescriptor>(
      role: role,
      glyphs: glyphs.map { row in
        row.map { resolver.resolve(structure: $0) }
      }
    )
  }
}

struct PartMap<T> where T: Hashable {
  private var map: [Box.PartRole: T] = [:]
  
  subscript(_ role: Box.PartRole) -> T? {
    get { map[role] }
    set { map[role] = newValue }
  }
  
  mutating func merge(_ other: PartMap<T>, combine: (T, T) -> T) {
    map.merge(other.map, uniquingKeysWith: combine)
  }
}
