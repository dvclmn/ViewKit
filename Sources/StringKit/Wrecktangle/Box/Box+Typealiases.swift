//
//  Box+Typealiases.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 13/11/2025.
//

public typealias Frame = Box.FrameStructure
public typealias GlyphSet = Box.GlyphSet

typealias GlyphGroup = Box.GlyphGroup

/// For `GlyphSet` builders. Describes design of individual `Character`s
public typealias Glyph = Box.Glyph

/// For use within Frame builders. Describes structure only, not design
public typealias GlyphType = Box.GlyphStructure

/// 2D array of structure-describing Glyphs
public typealias GlyphStack = [[Box.GlyphStructure]]

public typealias LinePart = Box.PartRole

typealias PartGroup = Box.PartGroup
public typealias Part = Box.PartStructure

extension Box {

  public typealias PartStructure = Box.Part<Box.GlyphStructure>
  public typealias PartResolved = Box.Part<Box.GlyphDescriptor>

  public typealias GlyphMap = [GlyphKey: Glyph]

  /// Allows the grouping of Parts (described by Structure-only),
  /// by their Role (aka Placement within the Box)
  public typealias PartMap = [Box.PartRole: Box.PartStructure]
}
