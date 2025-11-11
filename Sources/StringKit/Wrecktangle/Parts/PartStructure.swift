//
//  PartStructure.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 10/11/2025.
//

public typealias Part = Box.PartStructure

extension Box {
  /// Needs to have nothing to do with ``Box/GlyphDesign``
  /// Used in FrameBuilders
  public struct PartStructure: Sendable, Equatable, Codable, Hashable {
    /// What bit of the Box does this Part build
    let role: PartRole

    /// What glyphs are used to compose this Part
    let glyphs: [[GlyphStructure]]

    public init(
      _ role: PartRole,
      glyphs: [[GlyphStructure]]
    ) {
      self.role = role
      self.glyphs = glyphs
    }

    /// Builder init
    init(
      _ type: PartRole,
      @PartBuilder _ content: () -> [[GlyphStructure]]
    ) {
      self.role = type
      self.glyphs = Context.$currentRole.withValue(type) {
        content()
      }
    }
  }
}

extension Box.PartStructure {
  public var width: Int { glyphs.width(for: .widestRow) }
  public static var blank: Self { Part(.blank, glyphs: []) }

  public func resolved(with design: Box.GlyphDesign) -> Box.PartResolved {
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

    return Box.PartResolved(self.role, glyphs: resolvedGlyphs)
  }

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
    "Part[Glyphs: \(glyphs), W: \(width)]"
  }
}
