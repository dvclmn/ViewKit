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
  }

  static func buildArray(_ components: [BlockOutput]) -> BlockOutput {
    components.merged(keeping: .last)
  }

  static func buildEither(first: BlockOutput) -> BlockOutput { first }
  static func buildEither(second: BlockOutput) -> BlockOutput { second }
  static func buildOptional(_ component: BlockOutput?) -> BlockOutput {
    component ?? [:]
  }
}
extension FrameBuilder {
  
  static func buildExpression(_ expression: BlockInput) -> BlockInput {
    expression
  }
  
  static func buildExpression(_ expression: BlockOutput) -> BlockOutput {
    expression
  }
}
