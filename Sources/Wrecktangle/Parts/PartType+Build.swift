//
//  PartType+Build.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 2/11/2025.
//

import BasePrimitives
import Foundation

extension Box.PartRole {

  func part(
    using engine: Box.Engine,
    position: Box.PositionContext
  ) -> Box.PartStructure {

    print("quick check: \(self.pretty)")
    guard let part = engine.theme.frameStyle.frame.part(for: self) else {
      assertionFailure(
        "Missing \(self) for Frame Preset '\(engine.framePreset.name)', with Glyph design '\(engine.glyphDesign.name)'"
      )
      return .blank
    }
    return part
  }
}
