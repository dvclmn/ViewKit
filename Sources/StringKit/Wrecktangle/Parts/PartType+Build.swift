//
//  PartType+Build.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 2/11/2025.
//

import Foundation
import SharedHelpers

extension Box.PartRole {

  func part(
    using engine: Box.Engine,
    position: Box.PositionContext
  ) -> Box.PartStructure {
    guard let part = engine.theme.frameStyle.frame.part(for: self) else {
      assertionFailure("Missing \(self) for Frame Preset '\(engine.framePreset.name)', with Glyph design '\(engine.glyphDesign.name)'")
      return .blank
    }
    return part
  }
}

extension StringStack {
  public init(
    from descriptors: [[Box.GlyphDescriptor]],
    with theme: Box.Theme,
  ) {
    /// Convert from `GlyphType` → `Character`
    let characterGrid = descriptors.map { row in
      return row.map {
        return theme.glyphSet.resolve($0)
      }
    }
    self.init(characterGrid)
  }

}
