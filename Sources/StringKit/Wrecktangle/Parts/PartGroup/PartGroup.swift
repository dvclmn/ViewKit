//
//  PartGroup.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 12/11/2025.
//

typealias PartGroup = Box.PartGroup

extension Box {
  struct PartGroup: Sendable, Codable, Equatable {
    var parts: [Box.PartStructure] = []
    //    var map: PartMap = [:]

    //    public init(
    //      role: PartRole,
    //      glyphs: GlyphStack
    //    ) {
    //      let part = Box.PartStructure(role, glyphs: glyphs)
    //      let parts = [part]
    //      //      let merged = parts.merged(keeping: .last)
    //      let map = parts.toDictionary(key: \.role, value: \.self, keeping: .first)
    //      //      self.parts = [part]
    //      self.map = map
    //    }

    public init(parts: [Box.PartStructure]) {
      //      let map = parts.toDictionary(key: \.role, value: \.self, keeping: .first)
      self.parts = parts
      //      self.in
    }

    init(@PartGroupBuilder _ parts: () -> [Box.PartStructure]) {
      self.parts = parts()
    }
  }
}

//typealias Component = Box.GlyphStructure

@resultBuilder
enum PartGroupBuilder {
  typealias Component = Box.PartStructure
  static func buildBlock(_ components: [Component]...) -> [Component] {
    components.flatMap { $0 }
  }

  static func buildEither(first: [Component]) -> [Component] { first }
  static func buildEither(second: [Component]) -> [Component] { second }

  static func buildOptional(_ component: [Component]?) -> [Component] {
    component ?? []
  }
}

extension PartGroupBuilder {
  
  /// Add support for a single Array...
  public static func buildExpression(_ component: [Component]) -> [Component] {
    component
  }
  
  /// ... and a single Block
  public static func buildExpression(_ component: Component) -> [Component] {
    [component]
  }
//  static func buildBlock(_ component: Component, _ more: Component...) -> [Component] {
//    [component] + more
//  }
}
