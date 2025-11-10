//
//  Builder+Frame.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 7/11/2025.
//

public typealias FrameBuilderOutput = [Box.Part]

@resultBuilder
enum FrameBuilder {
  static func buildBlock(_ components: [Box.Part]...) -> FrameBuilderOutput {
    components.flatMap { $0 }
//    makeDict(components.flatMap { $0 })
    //    Dictionary(uniqueKeysWithValues: components.map { ($0.type, $0) })
  }

  public static func buildArray(_ components: [[Box.Part]]) -> [Box.Part] {
    components.flatMap { $0 }
//    components
//    [
//      reduceDict(components)
//    ]
//    makeDict(components)
//    components.flatMap { makeDict($0) }
  }

  static func buildEither(first: Box.Part) -> Box.Part { first }
  static func buildEither(second: Box.Part) -> Box.Part { second }
  static func buildOptional(_ component: [Box.Part]?) -> FrameBuilderOutput {
    component ?? []
  }
}

extension FrameBuilder {

  static func buildExpression(_ expression: Box.Part) -> FrameBuilderOutput {
    [expression]
//    //  static func buildArray(_ components: [Box.Part]) -> Box.PartMap {
//    //    makeDict(components)
//    //
  }

//  private static func makeDict(_ components: [Box.Part]) -> FrameBuilderOutput {
//
//  }
//  
//  private static func reduceDict(_ components: [Box.PartMap]) -> FrameBuilderOutput {
//    components.reduce(into: [:]) { $0.merge($1) { _, new in new } }
////    Dictionary(
////      uniqueKeysWithValues: components.map { part in
////        (part.type, part)
////      }
////    )
//  }
  

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
