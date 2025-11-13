//
//  Glyph.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 9/11/2025.
//
import SharedHelpers

/// For `GlyphSet` builders. Describes design of individual `Character`s
public typealias Glyph = Box.Glyph

extension Box {
  /// This should be what is visible *within* the `GlyphSet` builder
  /// ```
  /// GlyphSet {
  ///    Glyph("┌", .horizontal, .standard, .sharp)
  /// }
  /// ```
  /// I think this essentially provides a slightly nicer wrapper around `GlyphMap`
  public struct Glyph: Sendable {
    let character: Character
    let descriptor: GlyphDescriptor

    public init(
      _ character: Character,
      _ role: Box.GlyphRole,
      weight: Box.GlyphWeight = .standard,
    ) {
      self.character = character
      self.descriptor = .fromRole(role, weight: weight)
    }

    public init(
      _ character: Character,
      _ role: Box.GlyphRole,
      x: Box.GlyphWeight.WeightType = .standard,
      y: Box.GlyphWeight.WeightType = .standard,
    ) {
      self.init(
        character,
        role,
        weight: GlyphWeight(x: x, y: y),
      )
    }
  }

}
extension Box.Glyph {
  static let blank = Box.Glyph(.blank, .blank)
}

extension Box.Glyph: PrettyPrintable {

  public func prettyBody(_ config: PrettyPrintConfig, depth: Int) -> String {
    DisplayString {
      Labeled("character", value: character.pretty)
      Labeled("descriptor", value: descriptor.pretty(config, depth: depth))
    }.plainText
  }

  //  public func prettyDescription(_ config: PrettyPrintConfig, depth: Int) -> String {
  //    guard depth < config.maxDepth else { return "Person {...}" }
  //
  //    let ind = config.indent(depth)
  //    let nextInd = config.indent(depth + 1)
  //
  //    return """
  //      \(config.typeName(self)) {
  //      \(nextInd)character: \(character.prettyDescription(config, depth: depth + 1))
  //      \(nextInd)descriptor: \(character.prettyDescription(config, depth: depth + 1))
  //      \(ind)}
  //      """
  //  }
}
