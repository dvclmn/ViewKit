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

protocol PartMapConvertible {
  func asPartMap() -> Box.PartMap
}

extension Box.GlyphDescriptor: PartMapConvertible {
  func asPartMap() -> Box.PartMap {  }
}
