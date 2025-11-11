//
//  Part.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 5/11/2025.
//

import Foundation
import SharedHelpers

public typealias Part = Box.PartStructure
//public typealias Part = Box.PartResolved

extension Box {
  public typealias GlyphStack = [[GlyphDescriptor]]

  public struct PartResolved: Sendable, Codable, Equatable, Hashable {
    let role: PartRole
    let glyphs: GlyphStack
    
    init(type: PartRole, glyphs: [GlyphDescriptor]) {
      self.role = type
      self.glyphs = [glyphs]
    }

    init(
      _ type: PartRole,
      @PartBuilder _ content: () -> Box.GlyphStack
    ) {
      self.role = type
      self.glyphs = PartContext.$currentType.withValue(type) {
        content()
      }
    }
  }
}

extension Box.PartResolved {
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
    weight: Box.GlyphWeight = .standard,
    design: Box.GlyphDesign = .sharp
  ) {
    let glyphRole = Box.GlyphRole(fromPartType: role)
    let glyph = GlyphType(glyphRole, weight: weight, design: design)
    self.role = role
    self.glyphs = [[glyph]]
    
  }
}

extension Box.PartResolved {

  
  
  
  func toStringStack(with theme: Box.Theme) -> StringStack {
    StringStack(from: glyphs, with: theme)
  }
}

// MARK: - Part Context
/// This allows the leaving off of the `Box.GlyphType.join`'s
/// `Box.JoinType`, when declared in a `Part` builder closure.
/// For cleaner syntax.
///
/// Previously, the join type needed to be redundantly repeated, both
/// in the Part init, and the Glyph definition, as below:
/// ```
/// Part(.join(.leading)) {
///   Glyph.join(x: .increased, y: .standard, type: .leading)
/// }
/// ```
/// Now, using `PartContext` and `Box/GlyphType/join(x:y:)`
/// (the static property, not the enum case), I can omit the `type:`
/// argument, and the Part/Glyph join type is still correctly passed through.
/// ```
/// Part(.join(.leading)) {
///   Glyph.join(x: .increased, y: .standard)
/// }
/// ```
extension Box {
  enum PartContext {
    @TaskLocal static var currentType: Box.PartRole?
  }
}

extension Part: CustomStringConvertible {
  public var description: String {
    "Part[Glyphs: \(glyphs), W: \(width), StringStack: \(toStringStack(with: .default))]"
  }
}
