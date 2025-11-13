//
//  Part.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 5/11/2025.
//

import Foundation
import SharedHelpers

extension Box {
  public struct Part: Sendable, Codable, Equatable, Hashable {
    let role: PartRole

    let glyphs: [[GlyphDescriptor]]

    init(_ type: PartRole, glyphs: [[GlyphDescriptor]]) {
      self.role = type
      self.glyphs = glyphs
    }
  }
}

extension Box.Part {
  static func from(
    _ structure: Box.PartStructure,
    design: Box.GlyphDesign
  ) -> Self {
    structure.resolved(with: design)
  }
}

extension Box.Part {

  func toStringStack(with theme: Box.Theme) -> StringStack {
    StringStack(from: glyphs, with: theme)
  }
}

extension Box.Part: CustomStringConvertible {
  public var description: String {
    """
    Part[
      \(role.name),
      Glyphs:
    \(glyphs.indented(startingIndentation: 2))
    ]
    """
    //    "Part[Glyphs: \(glyphs), StringStack: \(toStringStack(with: .default))]"
    //    "Part[Glyphs: \(glyphs), W: \(width), StringStack: \(toStringStack(with: .default))]"
  }
}
