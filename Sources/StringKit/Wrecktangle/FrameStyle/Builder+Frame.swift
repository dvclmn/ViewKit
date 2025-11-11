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

  /// `buildArray` receives an array of whatever your builder’s
  /// base `buildBlock` returns.
  ///
  /// So if you have:
  /// ```
  /// buildBlock(_ components: Box.Part...) -> Box.PartMap
  /// ```
  ///
  /// then you get:
  /// ```
  /// buildArray(_ components: [Box.PartMap])
  /// ```
  ///
  /// That is — an array of dictionaries, not an array of single Parts.
  /// If you ever get an error like:
  ///
  /// > Cannot convert value of type `[Box.PartMap]`
  /// > to expected argument type `[Box.Part]`
  ///
  /// …it usually means you’ve changed one of the `build*` return types
  /// (say buildBlock returns `[Box.Part]` but buildArray expects `[Box.PartMap]`).
  /// They must all line up perfectly — that’s the most common “silent killer” in these setups.

  static func buildBlock(_ components: BlockInput...) -> BlockOutput {
    Dictionary(uniqueKeysWithValues: components.map { ($0.type, $0) })
  }

  public static func buildArray(_ components: [BlockOutput]) -> BlockOutput {
    components.reduce(into: [:]) { partial, partMap in
      partial.merge(partMap) { current, new in
        new
      }
    }
  }

  static func buildEither(first: BlockOutput) -> BlockOutput { first }
  static func buildEither(second: BlockOutput) -> BlockOutput { second }
  static func buildOptional(_ component: BlockOutput?) -> BlockOutput {
    component ?? [:]
  }
}

extension FrameBuilder {
  
  static func buildExpression(_ expression: BlockOutput) -> [BlockOutput] {
    [expression]
  }
}
