//
//  Builder+Frame.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 7/11/2025.
//

@resultBuilder
enum FrameBuilder {

  typealias BlockInput = Box.PartStructure
  typealias BlockOutput = Box.PartMap

  static func buildBlock(_ components: BlockInput...) -> BlockOutput {
    Dictionary(uniqueKeysWithValues: components.map { ($0.role, $0) })
  }

  public static func buildArray(_ components: BlockInput) -> BlockOutput {
//  public static func buildArray(_ components: BlockOutput) -> BlockOutput {
    
//    fatalError("Hold on")
//    components.reduce(into: [:]) { partial, partMap in
//      partial.merge(partMap) { current, new in
//        new
//      }
//    }
//  }

  static func buildEither(first: BlockOutput) -> BlockOutput { first }
  static func buildEither(second: BlockOutput) -> BlockOutput { second }
  static func buildOptional(_ component: BlockOutput?) -> BlockOutput {
    component ?? [:]
  }
}

extension FrameBuilder {

    static func buildExpression(_ expression: BlockInput) -> [BlockOutput] {
      fatalError("Thigninsf")
//      [expression]
    }
//  static func buildExpression(_ expression: BlockOutput) -> BlockOutput {
//    expression
//    [expression.role: expression]
//  }
  
//    static func buildExpression(_ expression: [BlockInput]) -> BlockOutput {
//      fatalError("Thigninsf")
//      [expression.role: expression]
//    }
}
