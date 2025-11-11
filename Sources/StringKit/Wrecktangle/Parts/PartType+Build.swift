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
    //  ) -> Box.PartResolved {
    guard let part = engine.theme.frameStyle.part(for: self) else {
      assertionFailure("Missing \(self) for Frame \(dump(engine.theme.frameStyle))")
      return .blank
    }
    return part
  }

  //  func part(
  //    using engine: Box.Engine,
  //    position: Box.PositionContext
  //  ) -> Box.Part {
  //    let frameStyle = engine.theme.frameStyle
  //    frameStyle.debugDump()
  //    let fallback = Part(.blank) { Row { GlyphType.blank } }
  //
  //    guard let part = frameStyle.part(for: self) else {
  //      fatalError("Missing \(self) in FrameStyle")
  //    }
  //
  //    //    guard let part = frameStyle.part(for: self) else {
  //    //      fatalError("What happened?")
  //    //    }
  //    //    return part
  //    return frameStyle.part(for: self) ?? fallback
  //  }
}

extension StringStack {
  public init(
    from descriptors: [[Box.GlyphDescriptor]],
//    from glyphStack: Box.GlyphStack,
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
