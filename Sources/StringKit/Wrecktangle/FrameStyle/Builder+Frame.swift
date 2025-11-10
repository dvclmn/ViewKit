//
//  Builder+Frame.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 7/11/2025.
//

@resultBuilder
enum FrameBuilder {
  static func buildBlock(_ components: Box.Part...) -> Box.PartMap {
    makeDict(components)
    //    Dictionary(uniqueKeysWithValues: components.map { ($0.type, $0) })
  }

  //  static func buildArray(_ components: [Box.PartMap]) -> Box.PartMap {
  //    components.reduce(into: [:]) { $0.merge($1) { _, new in new } }
  //  }

  /// `buildBlock` expects `Box.Part `elements.
  /// `buildArray` expects arrays of whatever `buildBlock’`s
  /// element type is (`Box.Part`), not already-built maps.
  ///
  /// Change your builder to align `buildArray`’s input with the type
  /// of `buildBlock`’s elements, not the final output
//  static func buildArray(_ components: [Box.Part]) -> Box.PartMap {
//    makeDict(components)
//  }
  
//  static func buildArray(_ components: [Box.Part]) -> Box.Part {
//  static func buildArray(_ components: [Box.Part]) -> Box.PartMap {
//    makeDict(components)
////    components.reduce(into: [:]) { $0.merge($1) { _, new in new } }
//  }
  
//  static func buildArray(_ components: [Box.PartMap]) -> Box.PartMap {
//    components.reduce(into: [:]) { $0.merge($1) { _, new in new } }
//  }

  static func buildEither(first: Box.PartMap) -> Box.PartMap { first }
  static func buildEither(second: Box.PartMap) -> Box.PartMap { second }
  static func buildOptional(_ component: Box.PartMap?) -> Box.PartMap {
    component ?? [:]
  }
}

extension FrameBuilder {
  
  
  static func buildExpression(_ expression: [Box.Part]) -> [Box.Part] {
    expression
    //  static func buildArray(_ components: [Box.Part]) -> Box.PartMap {
//    makeDict(components)
    //    components.reduce(into: [:]) { $0.merge($1) { _, new in new } }
  }
  
  private static func makeDict(_ components: [Box.Part]) -> Box.PartMap {
    Dictionary(uniqueKeysWithValues: components.map { ($0.type, $0) })
  }
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
