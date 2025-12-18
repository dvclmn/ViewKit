//
//  PartStructure.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 10/11/2025.
//

import CoreTools

extension Box.PartStructure {
  init(
    _ role: Box.PartRole,
    @PartBuilder _ content: () -> GlyphStack
  ) {
    self.role = role
    self.glyphs = Context.$currentRole.withValue(role) {
      content()
    }
  }
}


extension Box.PartStructure {

  public static var blank: Self { Part(.blank, glyphs: []) }
  public var width: Int { glyphs.width(for: .widestRow) }

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

extension Box.PartStructure {
  public func prettyBody(_ config: PrettyPrintConfig, depth: Int) -> String {
    DisplayString {
      Labeled("role", value: role.name.pretty(config, depth: depth))
      Labeled("glyphs", value: glyphs.pretty(config, depth: depth))
    }.plainText
  }
}
