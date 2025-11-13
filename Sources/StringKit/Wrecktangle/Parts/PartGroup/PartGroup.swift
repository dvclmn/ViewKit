//
//  PartGroup.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 12/11/2025.
//

extension Box {
  struct PartGroup: Sendable, Codable, Equatable {
    var parts: [Box.PartStructure] = []

    public init(parts: [Box.PartStructure]) {
      self.parts = parts
    }

    init(@PartGroupBuilder _ parts: () -> [Box.PartStructure]) {
      self.parts = parts()
    }
  }
}

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
  public static func buildExpression(_ component: [Component]) -> [Component] {
    component
  }

  public static func buildExpression(_ component: Component) -> [Component] {
    [component]
  }
}
