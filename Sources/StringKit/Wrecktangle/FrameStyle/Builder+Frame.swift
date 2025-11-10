//
//  Builder+Frame.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 7/11/2025.
//

@resultBuilder
enum FrameBuilder {
  static func buildBlock(_ components: [Box.Part]...) -> Box.PartMap {
    makeDict(components.flatMap { $0 })
    //    Dictionary(uniqueKeysWithValues: components.map { ($0.type, $0) })
  }

  public static func buildArray(_ components: [Box.PartMap]) -> [Box.PartMap] {
    [
      reduceDict(components)
    ]
//    makeDict(components)
//    components.flatMap { makeDict($0) }
  }

  static func buildEither(first: Box.PartMap) -> Box.PartMap { first }
  static func buildEither(second: Box.PartMap) -> Box.PartMap { second }
  static func buildOptional(_ component: Box.PartMap?) -> Box.PartMap {
    component ?? [:]
  }
}

extension FrameBuilder {

  static func buildExpression(_ expression: Box.Part) -> [Box.Part] {
    [
      expression
    ]
    //  static func buildArray(_ components: [Box.Part]) -> Box.PartMap {
    //    makeDict(components)
    //
  }

  private static func makeDict(_ components: [Box.Part]) -> Box.PartMap {
    Dictionary(
      uniqueKeysWithValues: components.map { part in
        (part.type, part)
      }
    )
  }
  
  private static func reduceDict(_ components: [Box.PartMap]) -> Box.PartMap {
    components.reduce(into: [:]) { $0.merge($1) { _, new in new } }
//    Dictionary(
//      uniqueKeysWithValues: components.map { part in
//        (part.type, part)
//      }
//    )
  }
  

  //  private static func makeGridDict(_ components: [[Box.Part]]) -> Box.PartMap {
  //    Dictionary(
  //      uniqueKeysWithValues: components.flatMap { parts in
  //        parts.map { part in
  //          (part.type, part)
  //        }
  //
  //      }
  //    )
  //  }

}

//protocol PartMapConvertible {
//  func asPartMap() -> Box.PartMap
//}
//
//extension Box.GlyphType: PartMapConvertible {
//  func asPartMap() -> Box.PartMap {
//
//  }
//}
