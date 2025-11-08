//
//  Builder+Frame.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 7/11/2025.
//

@resultBuilder
enum FrameBuilder {
  static func buildBlock(_ components: Box.Part...) -> Box.PartMap {
    Dictionary(uniqueKeysWithValues: components.map { ($0.type, $0) })
  }

  static func buildArray(_ components: [Box.PartMap]) -> Box.PartMap {
    components.reduce(into: [:]) { $0.merge($1) { _, new in new } }
  }

  static func buildEither(first: Box.PartMap) -> Box.PartMap { first }
  static func buildEither(second: Box.PartMap) -> Box.PartMap { second }
  static func buildOptional(_ component: Box.PartMap?) -> Box.PartMap {
    component ?? [:]
  }
}

//@resultBuilder
//enum FrameStyleBuilder {
//  static func buildBlock(_ components: (Box.PartType, Box.Part)...) -> [Box.PartType: Box.Part] {
//    Dictionary(uniqueKeysWithValues: components)
//  }
//
//  static func buildArray(_ components: [[Box.PartType: Box.Part]]) -> [Box.PartType: Box.Part] {
//    components.reduce(into: [:]) { result, next in
//      result.merge(next) { _, new in new }
//    }
//  }
//
//  static func buildEither(first: [Box.PartType: Box.Part]) -> [Box.PartType: Box.Part] { first }
//  static func buildEither(second: [Box.PartType: Box.Part]) -> [Box.PartType: Box.Part] { second }
//
//  static func buildOptional(_ component: [Box.PartType: Box.Part]?) -> [Box.PartType: Box.Part] {
//    component ?? [:]
//  }
//}
//
