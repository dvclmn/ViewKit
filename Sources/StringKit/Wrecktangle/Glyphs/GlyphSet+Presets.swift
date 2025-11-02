//
//  Glyphs.swift
//  BoxCore
//
//  Created by Dave Coleman on 23/8/2024.
//

import Foundation

/// This attempts to describe a glyph based on it's usage,
/// rather than neccesarily it's appearance / visual qualitites
extension Box.GlyphSet {

  public static let sharp = Box.GlyphSet.base(
    [
      Box.GlyphType.blank: Character.blank,

      // MARK: - Floor/Ceiling
      Box.GlyphType.horizontal(.increased): "━",
      Box.GlyphType.horizontal(.standard): "─",

      // MARK: - Walls
      Box.GlyphType.vertical(.increased): "┃",
      Box.GlyphType.vertical(.standard): "│",

      // MARK: - Bold to Thin Joins
      Box.GlyphType.join(x: .increased, y: .standard, type: .top): "┯",
      Box.GlyphType.join(x: .increased, y: .standard, type: .bottom): "┷",
      Box.GlyphType.join(x: .standard, y: .increased, type: .leading): "┠",
      Box.GlyphType.join(x: .standard, y: .increased, type: .trailing): "┨",

      // MARK: - Bold Joins
      Box.GlyphType.join(x: .increased, y: .increased, type: .top): "┳",
      Box.GlyphType.join(x: .increased, y: .increased, type: .bottom): "┻",
      Box.GlyphType.join(x: .increased, y: .increased, type: .leading): "┣",
      Box.GlyphType.join(x: .increased, y: .increased, type: .trailing): "┫",
      Box.GlyphType.join(x: .increased, y: .increased, type: .cross): "╋",

      // MARK: - Thin Joins
      Box.GlyphType.join(x: .standard, y: .standard, type: .top): "┬",
      Box.GlyphType.join(x: .standard, y: .standard, type: .bottom): "┴",
      Box.GlyphType.join(x: .standard, y: .standard, type: .leading): "├",
      Box.GlyphType.join(x: .standard, y: .standard, type: .trailing): "┤",
      Box.GlyphType.join(x: .standard, y: .standard, type: .cross): "┼",

      // MARK: - Bold Corners
      Box.GlyphType.corner(.increased, type: .topLeading): "┏",
      Box.GlyphType.corner(.increased, type: .topTrailing): "┓",
      Box.GlyphType.corner(.increased, type: .bottomLeading): "┗",
      Box.GlyphType.corner(.increased, type: .bottomTrailing): "┛",

      // MARK: - Thin Corners
      Box.GlyphType.corner(.standard, type: .topLeading): "┌",
      Box.GlyphType.corner(.standard, type: .topTrailing): "┐",
      Box.GlyphType.corner(.standard, type: .bottomLeading): "└",
      Box.GlyphType.corner(.standard, type: .bottomTrailing): "┘",

    ]
  )

  public static let rounded = Box.GlyphSet.partial(
    [

      Box.GlyphType.horizontal(.standard): "─",
      
      Box.GlyphType.vertical(.standard): "│",
      
      Box.GlyphType.join(x: .standard, y: .standard, type: .top): "┬",
      Box.GlyphType.join(x: .standard, y: .standard, type: .bottom): "┴",
      Box.GlyphType.join(x: .standard, y: .standard, type: .leading): "├",
      Box.GlyphType.join(x: .standard, y: .standard, type: .trailing): "┤",
      Box.GlyphType.join(x: .standard, y: .standard, type: .cross): "┼",
      
      Box.GlyphType.corner(.standard, type: .topLeading): "╭",
      Box.GlyphType.corner(.standard, type: .topTrailing): "╮",
      Box.GlyphType.corner(.standard, type: .bottomLeading): "╰",
      Box.GlyphType.corner(.standard, type: .bottomTrailing): "╯",

    ], sharp)

  public static let test = Box.GlyphSet.partial(
    [

      Box.GlyphType.horizontal(.increased): "M",  // ░

      Box.GlyphType.vertical(.increased): "S",

      Box.GlyphType.join(x: .increased, y: .increased, type: .top): "T",
      Box.GlyphType.join(x: .increased, y: .increased, type: .bottom): "B",
      Box.GlyphType.join(x: .increased, y: .increased, type: .leading): "L",
      Box.GlyphType.join(x: .increased, y: .increased, type: .trailing): "R",

      Box.GlyphType.corner(.regular, type: .topLeading): "r",
      Box.GlyphType.corner(.regular, type: .topTrailing): "a",
      Box.GlyphType.corner(.regular, type: .bottomLeading): "m",
      Box.GlyphType.corner(.regular, type: .bottomTrailing): "s",

    ], sharp)

  public static let double = Box.GlyphSet.partial(
    [

      Box.GlyphType.horizontal(.increased): "═",
      Box.GlyphType.horizontal(.standard): "─",

      Box.GlyphType.vertical(.increased): "║",
      Box.GlyphType.vertical(.standard): "│",

      Box.GlyphType.join(x: .increased, y: .standard, type: .top): "╤",
      Box.GlyphType.join(x: .increased, y: .standard, type: .bottom): "╧",
      Box.GlyphType.join(x: .standard, y: .increased, type: .leading): "╟",
      Box.GlyphType.join(x: .standard, y: .increased, type: .trailing): "╢",
      Box.GlyphType.join(x: .standard, y: .standard, type: .cross): "┼",

      Box.GlyphType.corner(.increased, type: .topLeading): "╔",
      Box.GlyphType.corner(.increased, type: .topTrailing): "╗",
      Box.GlyphType.corner(.increased, type: .bottomLeading): "╚",
      Box.GlyphType.corner(.increased, type: .bottomTrailing): "╝",

      Box.GlyphType.corner(.standard, type: .topLeading): "┌",
      Box.GlyphType.corner(.standard, type: .topTrailing): "┐",
      Box.GlyphType.corner(.standard, type: .bottomLeading): "└",
      Box.GlyphType.corner(.standard, type: .bottomTrailing): "┘",

    ], sharp)

}

extension Character {
  public static var blank: Character { " " }
}
