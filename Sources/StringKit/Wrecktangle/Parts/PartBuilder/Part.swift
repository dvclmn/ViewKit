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

//    init(_ type: Box.PartType, @PartBuilder _ content: () -> Box.GlyphStack) {
//      self.glyphs = content()
//      self.type = type
//    }
  }
}

extension Box.Part {
  
  init(_ type: Box.PartType, @PartBuilder _ content: () -> Box.GlyphStack) {
    self.type = type
    self.glyphs = PartContext.$currentType.withValue(type) {
      content()
    }
  }
  
  var width: Int { glyphs.width(for: .widestRow) }

  func toStringStack(with theme: Box.Theme) -> StringStack {
    StringStack(from: glyphs, with: theme)
  }
}


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


extension Box.GlyphType {
  static func join(x: Box.GlyphProminence, y: Box.GlyphProminence) -> Self {
    guard case .join(let joinType)? = PartContext.currentType else {
      fatalError("join(x:y:) used outside a join Part")
    }
    return .join(x: x, y: y, type: joinType)
  }
  
  static func corner(_ prominence: Box.GlyphProminence) -> Self {
    guard case .corner(let cornerType)? = PartContext.currentType else {
      fatalError("corner(_:) used outside a corner Part")
    }
    return .corner(prominence, type: cornerType)
  }
}

// MARK: - Part Span
extension Box {
  public enum PartSpan {
    case fill
    case fixed(Int)

    public static var single: PartSpan { .fixed(1) }
  }
}

extension Part: CustomStringConvertible {
  public var description: String {
    "Part[Glyphs: \(glyphs), W: \(width), StringStack: \(toStringStack(with: .default))]"
  }
}
