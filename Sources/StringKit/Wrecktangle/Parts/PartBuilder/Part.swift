//
//  Part.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 5/11/2025.
//

import Foundation

public typealias Part = Box.Part
extension Box {

  public struct Part: Sendable, Codable, Equatable {
    let type: PartType
    let glyphs: GlyphStack

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
enum PartContext {
  @TaskLocal static var currentType: Box.PartType?
}

extension Part: CustomStringConvertible {
  public var description: String {
    "Part[Glyphs: \(glyphs), W: \(width), StringStack: \(toStringStack(with: .default))]"
  }
}
