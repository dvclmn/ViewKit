//
//  Line+Structure.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 5/11/2025.
//

import Foundation

extension Box {
  struct StructureLine {
    let leading: Box.PartType
    let repeating: Box.PartType
    let trailing: Box.PartType

    init(
      _ leading: Box.PartType,
      _ repeating: Box.PartType,
      _ trailing: Box.PartType
    ) {
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
      config: engine.config,
      at: position
    )

    let lead = leading.buildPart(using: partEngine)
    let trail = trailing.buildPart(using: partEngine)
    let repeated = repeating.buildPart(
      using: partEngine,
      repeating: engine.repeatedPartWidth
    )
    
    return StringStack.joined(
      lead,
      repeated,
      trail,
      along: .horizontal
    ).string
  }
}
