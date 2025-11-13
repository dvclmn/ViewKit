//
//  DesignResolved.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 13/11/2025.
//

/// Represents a structure that has been paired with a design
//protocol DesignResolved {
//  associatedtype Structure
//  associatedtype Design
//
//  var structure: Structure { get }
//  var design: Design { get }
//}

extension Box {
  struct Resolver {
    let glyphSet: Box.GlyphSet

    /// Resolve a single GlyphStructure → GlyphDescriptor
    func resolve(structure: GlyphStructure) -> GlyphDescriptor {
      GlyphDescriptor(structure, design: glyphSet.design)
    }

    /// Resolve an entire PartStructure → PartResolved
    func resolve(part: PartStructure) -> PartResolved {
      PartResolved(
        part.role,
        glyphs: part.glyphs.map { row in
          row.map { resolve(structure: $0) }
        }
      )
    }
  }
}

extension Box.Resolver {
  func characters(from descriptors: [[Box.GlyphDescriptor]]) -> [[Character]] {
    descriptors.map { row in
      row.map { glyphSet.character(for: $0) }
    }
  }

  func characters(from part: Box.PartResolved) -> [[Character]] {
    characters(from: part.glyphs)
  }
}

//struct PartMap<T> where T: Hashable {
//  private var map: [Box.PartRole: T] = [:]
//
//  subscript(_ role: Box.PartRole) -> T? {
//    get { map[role] }
//    set { map[role] = newValue }
//  }
//
//  mutating func merge(_ other: PartMap<T>, combine: (T, T) -> T) {
//    map.merge(other.map, uniquingKeysWith: combine)
//  }
//}
