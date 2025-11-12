//
//  Builder+Frame.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 7/11/2025.
//

import SharedHelpers

@resultBuilder
enum FrameBuilder {

  typealias BlockInput = Box.PartStructure
  typealias BlockOutput = Box.PartMap

  static func buildBlock(_ components: BlockInput...) -> BlockOutput {
    components.toDictionary(key: \.role, value: \.self)

//    Dictionary(components) { current, new in
//      new
//    }
//    Dictionary(uniqueKeysWithValues: components.map { ($0.role, $0) })
  }

  public static func buildArray(_ components: [BlockOutput]) -> BlockOutput {
    components.merged(keeping: .new)
//    Box.reduce(components)
  }

  static func buildEither(first: BlockOutput) -> BlockOutput { first }
  static func buildEither(second: BlockOutput) -> BlockOutput { second }
  static func buildOptional(_ component: BlockOutput?) -> BlockOutput {
    component ?? [:]
  }
}
