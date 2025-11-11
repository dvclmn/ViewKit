//
//  Part.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 5/11/2025.
//

import Foundation
import SharedHelpers

//public typealias Part = Box.PartResolved

extension Box {
  //  public typealias GlyphStack = [[GlyphDescriptor]]

  public struct PartResolved: Sendable, Codable, Equatable, Hashable {
    let role: PartRole
    let glyphs: [[GlyphDescriptor]]

    init(_ type: PartRole, glyphs: [[GlyphDescriptor]]) {
      self.role = type
      self.glyphs = glyphs
    }

  }
}

extension Box.PartResolved {
  static func from(_ structure: Box.PartStructure, design: Box.GlyphDesign) -> Self {
    structure.resolved(with: design)
  }
}

extension Box.PartResolved {

  func toStringStack(with theme: Box.Theme) -> StringStack {
    StringStack(from: glyphs, with: theme)
  }
}

extension Box.PartResolved: CustomStringConvertible {
  public var description: String {
    "Part[Glyphs: \(glyphs), StringStack: \(toStringStack(with: .default))]"
    //    "Part[Glyphs: \(glyphs), W: \(width), StringStack: \(toStringStack(with: .default))]"
  }
}
