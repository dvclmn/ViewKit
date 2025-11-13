//
//  Part.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 5/11/2025.
//

import Foundation
import SharedHelpers

typealias PartStructure = Box.Part<Box.GlyphStructure>
typealias PartResolved  = Box.Part<Box.GlyphDescriptor>

extension Box {
  
  public protocol GlyphKind: Sendable, Codable, Hashable {}
  
  public struct Part<T: GlyphKind>: Sendable, Codable, Hashable {
    let role: PartRole
    let glyphs: [[T]]
  }
  
//  public struct Part: Sendable, Codable, Equatable, Hashable {
//    let role: PartRole
//
//    let glyphs: [[GlyphDescriptor]]
//
//    init(_ type: PartRole, glyphs: [[GlyphDescriptor]]) {
//      self.role = type
//      self.glyphs = glyphs
//    }
//  }
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

extension Box.Part: PrettyPrintable {

  public func prettyBody(_ config: PrettyPrintConfig, depth: Int) -> String {
    DisplayString {
      Labeled("role", value: role.pretty(config, depth: depth))
      Labeled("glyphs", value: glyphs.pretty(config, depth: depth))
    }.plainText
  }

  //  public func pretty(_ config: PrettyPrintConfig, depth: Int) -> String {
  //    guard depth < config.maxDepth else { return "Person {...}" }
  //
  //    let ind = config.indent(depth)
  //    let nextInd = config.indent(depth + 1)
  //
  //    return """
  //      \(config.typeName(self))Person {
  //      \(nextInd)role: \(role.name.pretty(config, depth: depth + 1))
  //      \(nextInd)glyphs: \(glyphs.pretty(config, depth: depth + 1))
  //      \(ind)}
  //      """
  //  }
}

extension Box.Part: CustomStringConvertible {

  public var description: String { self.pretty }

  //    """
  //    Part[
  //      \(role.name),
  //      Glyphs:
  //    \(glyphs.indented(startingIndentation: 2))
  //    ]
  //    """
  //    "Part[Glyphs: \(glyphs), StringStack: \(toStringStack(with: .default))]"
  //    "Part[Glyphs: \(glyphs), W: \(width), StringStack: \(toStringStack(with: .default))]"
  //  }
}
