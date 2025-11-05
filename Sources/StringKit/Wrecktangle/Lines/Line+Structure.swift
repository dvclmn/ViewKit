//
//  Line+Structure.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 5/11/2025.
//

import Foundation

extension Box {
  struct StructureLine {
    //    let engine: Box.PartEngine
    let leading: Box.PartType
    let repeating: Box.PartType
    let trailing: Box.PartType

    init(
      _ leading: Box.PartType,
      _ repeating: Box.PartType,
      _ trailing: Box.PartType
    ) {
      //      self.engine = .init(theme: .default)
      self.leading = leading
      self.repeating = repeating
      self.trailing = trailing
    }
  }
}
extension Box.StructureLine: Box.RenderableLine {
  func buildString(
    using engine: Box.Engine,
    at position: Box.PositionContext
  ) -> String {

    let partEngine = Box.PartEngine(
      theme: engine.theme,
      at: position
    )

    let lead = leading.buildPart(using: partEngine)
    let trail = trailing.buildPart(using: partEngine)
    let repeated = repeating.buildPart(using: partEngine, repeating: engine.repeatedPartWidth)
    return StringStack.joined(lead, repeated, trail, along: .horizontal).string
  }
}
//
//
//
//extension Box.StructureLine {
//  func buildParts(
//    using engine: Box.Engine
//  ) -> String {
//    let leadStr = leading.buildPart(with: engine.theme)
//    let trailStr = trailing.buildPart(with: engine.theme)
//    let repeatStr = repeating.buildPart(with: engine.theme, repeatCount: engine.repeatedPartWidth)
//
//    let string = StringStack.joined(
//      leadStr, repeatStr, trailStr,
//      along: .horizontal
//    ).string
//
//    return string
//  }
//}
