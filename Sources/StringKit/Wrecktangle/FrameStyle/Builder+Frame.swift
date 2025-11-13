//
//  Builder+Frame.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 7/11/2025.
//

import SharedHelpers

@resultBuilder
enum FrameBuilder {

  typealias Components = Box.PartStructure
  typealias OutputMap = Box.PartMap

  static func buildBlock(_ components: Components...) -> OutputMap {
    components.toDictionary(key: \.role, value: \.self, keeping: .last)
  }

  static func buildArray(_ components: [OutputMap]) -> OutputMap {
    components.merged(keeping: .last)
  }

  static func buildEither(first: OutputMap) -> OutputMap { first }
  static func buildEither(second: OutputMap) -> OutputMap { second }
  static func buildOptional(_ component: OutputMap?) -> OutputMap {
    component ?? [:]
  }
}
extension FrameBuilder {

  static func buildExpression(_ expression: Components) -> Components {
    expression
  }

  static func buildExpression(_ expression: OutputMap) -> OutputMap {
    expression
  }
}
