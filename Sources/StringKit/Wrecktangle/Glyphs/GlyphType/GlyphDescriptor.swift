//
//  Glyph+Descriptor.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 8/11/2025.
//

import Foundation

extension Box {
  public struct GlyphDescriptor: Hashable, Codable, Sendable {
    let structure: GlyphStructure
    let design: GlyphDesign

    public init(
      _ role: GlyphRole,
      weight: GlyphWeight = .standard,
      design: GlyphDesign
//      design: GlyphDesign = .sharp
    ) {
      self.structure = .init(role, weight: weight)
      self.design = design
    }
  }
}

extension Box.GlyphDescriptor {
  public var role: Box.GlyphRole { structure.role }
  public var weight: Box.GlyphWeight { structure.weight }

  static func fromRole(
    _ role: Box.GlyphRole,
    weight: Box.GlyphWeight = .standard,
//    design: Box.GlyphDesign? = nil
  ) -> Self {

    let resolved = GlyphDesignContext.currentDesign
//    let resolved = design ?? GlyphDesignContext.currentDesign
    guard let resolved else {
      fatalError("Why is this tripping?")
      //      return
    }

    return .init(role, weight: weight, design: resolved)
    //    let resolvedDesign = design ?? GlyphDesignContext.currentDesign ?? .sharp
  }

}

extension Box.GlyphDescriptor: CustomStringConvertible {
  public var description: String {
    "GlyphType[GlyphRole/\(role.name), Weight/\(weight), Design/\(design.rawValue)]"
  }
}
