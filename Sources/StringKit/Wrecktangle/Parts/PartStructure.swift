//
//  PartStructure.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 10/11/2025.
//

import SharedHelpers

public typealias Part = Box.PartStructure

extension Box {
  /// Needs to have nothing to do with ``Box/GlyphDesign``
  /// Used in FrameBuilders
  public struct PartStructure: Sendable, Equatable, Codable, Hashable {
    /// What bit of the Box does this Part build
    let role: PartRole

    /// What glyphs are used to compose this Part
    /// Go straight to ``Box/GlyphStructure``
    let glyphs: GlyphStack

    public init(
      _ role: PartRole,
      glyphs: GlyphStack
    ) {
      self.role = role
      self.glyphs = glyphs
    }

    init(
      _ role: PartRole,
      @PartBuilder _ content: () -> GlyphStack
    ) {
      self.role = role
      self.glyphs = Context.$currentRole.withValue(role) {
        content()
      }
    }
  }
}

extension Box.PartStructure {
  public func resolved(with design: Box.GlyphDesign) -> Box.Part {
    let resolvedGlyphs: [[Box.GlyphDescriptor]] = glyphs.map { row in
      row.map { glyph in
        let role = Box.GlyphRole(fromPartRole: self.role)
        return Box.GlyphDescriptor(
          role,
          weight: glyph.weight,
          design: design
        )
      }
    }
    
    return Box.Part(self.role, glyphs: resolvedGlyphs)
  }
  public var width: Int { glyphs.width(for: .widestRow) }
  public static var blank: Self { Part(.blank, glyphs: []) }
  

//  func merged(with other: Self) -> Box.PartMap {
////  func merged(with other: Self) -> Self {
//    guard role == other.role else {
//      return self.
//    }
//    let mergedGlyphs = self.glyphs + other.glyphs
//    return Self(role, glyphs: mergedGlyphs)
//  }



  enum Context {
    @TaskLocal static var currentRole: Box.PartRole?
  }
}

extension Box.PartStructure {
  /// Handy overload for when there's only one Row,
  /// and one Glyph in that Row. For very simplistic Frames.
  ///
  /// ```
  /// // Instead of this:
  /// Frame {
  ///   Part(.horizontal(.top)) {
  ///     GlyphType.h(.increased, .hollow)
  ///   }
  /// }
  ///
  /// // We can write this:
  /// Frame {
  ///   Part(.horizontal(.top), weight: .increased, style: .hollow)
  /// }
  /// ```
  public init(
    _ role: Box.PartRole,
    weight: Box.GlyphWeight = .standard
  ) {
    let glyphRole = Box.GlyphRole(fromPartRole: role)
    let glyph = Box.GlyphStructure(glyphRole, weight: weight)
    self.role = role
    self.glyphs = [[glyph]]
  }
}

extension Box.PartStructure: CustomStringConvertible {
  public var description: String {
    //    "Part[Glyphs: \(glyphs), StringStack: \(toStringStack(with: .default))]"
    "Part[\n\t\(role.name),\n\tGlyphs:\n\(glyphs.indented(startingIndentation: 2))\n\tWidth: \(width)\n]"
  }
}

extension Box.PartStructure: PrettyPrintable {
  public func prettyDescription(_ config: PrettyPrintConfig, depth: Int) -> String {
    guard depth < config.maxDepth else { return "\(config.typeName(self)) {...}" }
    
    let ind = config.indent(depth)
    let nextInd = config.indent(depth + 1)
    
    return """
      \(config.typeName(self)) {
      \(nextInd)role: \(role.prettyDescription(config, depth: depth + 1))
      \(nextInd)glyphs: \(glyphs.prettyDescription(config, depth: depth + 1))
      \(ind)}
      """
  }
}
