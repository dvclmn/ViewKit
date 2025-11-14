//
//  Builder+PartGroup.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 13/11/2025.
//

//@resultBuilder
//enum PartGroupBuilder {
//  typealias Component = Box.PartStructure
//  static func buildBlock(_ components: [Component]...) -> [Component] {
//    components.flatMap { $0 }
//  }
//
//  static func buildEither(first: [Component]) -> [Component] { first }
//  static func buildEither(second: [Component]) -> [Component] { second }
//
//  static func buildOptional(_ component: [Component]?) -> [Component] {
//    component ?? []
//  }
//}
//
//extension PartGroupBuilder {
//  public static func buildExpression(_ component: [Component]) -> [Component] {
//    component
//  }
//
//  public static func buildExpression(_ component: Component) -> [Component] {
//    [component]
//  }
//}
