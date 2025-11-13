//
//  Glyph+Descriptor.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 8/11/2025.
//

import Foundation
import SharedHelpers

extension Box {
  public struct GlyphDescriptor: DesignResolved, GlyphKind {
    let structure: GlyphStructure
    let design: GlyphDesign

    public init(
      _ role: GlyphRole,
      weight: GlyphWeight = .standard,
      design: GlyphDesign
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
  ) -> Self {

    let resolved = GlyphDesignContext.currentDesign
    guard let resolved else {
      fatalError("Why is this tripping?")
    }

    return .init(role, weight: weight, design: resolved)
  }
}

extension Box.GlyphDescriptor: CustomStringConvertible {
  public var description: String {
    """
    Part[
    \(role.name),
    Weight: 
    ]
    """

    //    "GlyphDescriptor[GlyphRole/\(role.name), Weight/\(weight), Design/\(design.rawValue)]"
  }
}
extension Box.GlyphDescriptor: PrettyPrintable {

  public func prettyBody(_ config: PrettyPrintConfig, depth: Int) -> String {
    DisplayString {
      Labeled("structure", value: structure.pretty(config, depth: depth))
      Labeled("design", value: design.name.pretty(config, depth: depth))
    }.plainText
  }

  //  public func prettyDescription(_ config: PrettyPrintConfig, depth: Int) -> String {
  //    guard depth < config.maxDepth else { return "Person {...}" }
  //
  //    let ind = config.indent(depth)
  //    let nextInd = config.indent(depth + 1)
  //
  //    return """
  //      \(config.typeName(self)) {
  //      \(nextInd)structure: \(structure.prettyDescription(config, depth: depth + 1))
  //      \(nextInd)design: \(design.name.prettyDescription(config, depth: depth + 1))
  //      \(ind)}
  //      """
  //  }
}
