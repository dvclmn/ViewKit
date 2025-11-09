//
//  Part.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 5/11/2025.
//

import Foundation

public typealias Part = Box.Part

extension Box {
  public typealias GlyphStack = [[GlyphType]]

  public struct Part: Sendable, Codable, Equatable {
    let type: PartType
    let glyphs: GlyphStack
    
    init(type: Box.PartType, glyphs: [GlyphType]) {
      self.type = type
      self.glyphs = [glyphs]
    }

    init(
      _ type: Box.PartType,
      @PartBuilder _ content: () -> Box.GlyphStack
    ) {
      self.type = type
      self.glyphs = PartContext.$currentType.withValue(type) {
        content()
      }
    }
  }
}

extension Box.Part {
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
    _ type: Box.PartType,
    weight: GlyphType.Prominence = .standard,
    design: GlyphType.Design = .sharp
  ) {
    let role = Box.GlyphType.Role(fromPartType: type)
    let glyph = GlyphType(role, weight: weight, design: design)
  }
}

extension Box.Part {
  var width: Int { glyphs.width(for: .widestRow) }
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
    @TaskLocal static var currentType: Box.PartType?
  }
}

extension Part: CustomStringConvertible {
  public var description: String {
    "Part[Glyphs: \(glyphs), W: \(width), StringStack: \(toStringStack(with: .default))]"
  }
}
