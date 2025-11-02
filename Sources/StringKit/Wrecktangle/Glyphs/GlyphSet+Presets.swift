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
      Box.GlyphType.horizontal(.strong): "━",
      Box.GlyphType.horizontal(.light): "─",

      // MARK: - Walls
      Box.GlyphType.vertical(.strong): "┃",
      Box.GlyphType.vertical(.light): "│",

      // MARK: - Bold to Thin Joins
      Box.GlyphType.join(x: .strong, y: .light, type: .top): "┯",
      Box.GlyphType.join(x: .strong, y: .light, type: .bottom): "┷",
      Box.GlyphType.join(x: .light, y: .strong, type: .leading): "┠",
      Box.GlyphType.join(x: .light, y: .strong, type: .trailing): "┨",

      // MARK: - Bold Joins
      Box.GlyphType.join(x: .strong, y: .strong, type: .top): "┳",
      Box.GlyphType.join(x: .strong, y: .strong, type: .bottom): "┻",
      Box.GlyphType.join(x: .strong, y: .strong, type: .leading): "┣",
      Box.GlyphType.join(x: .strong, y: .strong, type: .trailing): "┫",
      Box.GlyphType.join(x: .strong, y: .strong, type: .cross): "╋",

      // MARK: - Thin Joins
      Box.GlyphType.join(x: .light, y: .light, type: .top): "┬",
      Box.GlyphType.join(x: .light, y: .light, type: .bottom): "┴",
      Box.GlyphType.join(x: .light, y: .light, type: .leading): "├",
      Box.GlyphType.join(x: .light, y: .light, type: .trailing): "┤",
      Box.GlyphType.join(x: .light, y: .light, type: .cross): "┼",

      // MARK: - Bold Corners
      Box.GlyphType.corner(.strong, type: .topLeading): "┏",
      Box.GlyphType.corner(.strong, type: .topTrailing): "┓",
      Box.GlyphType.corner(.strong, type: .bottomLeading): "┗",
      Box.GlyphType.corner(.strong, type: .bottomTrailing): "┛",

      // MARK: - Thin Corners
      Box.GlyphType.corner(.light, type: .topLeading): "┌",
      Box.GlyphType.corner(.light, type: .topTrailing): "┐",
      Box.GlyphType.corner(.light, type: .bottomLeading): "└",
      Box.GlyphType.corner(.light, type: .bottomTrailing): "┘",

    ]
  )

  public static let rounded = Box.GlyphSet.partial(
    [

      Box.GlyphType.horizontal(.light): "─",
      
      Box.GlyphType.vertical(.light): "│",
      
      Box.GlyphType.join(x: .light, y: .light, type: .top): "┬",
      Box.GlyphType.join(x: .light, y: .light, type: .bottom): "┴",
      Box.GlyphType.join(x: .light, y: .light, type: .leading): "├",
      Box.GlyphType.join(x: .light, y: .light, type: .trailing): "┤",
      Box.GlyphType.join(x: .light, y: .light, type: .cross): "┼",
      
      Box.GlyphType.corner(.light, type: .topLeading): "╭",
      Box.GlyphType.corner(.light, type: .topTrailing): "╮",
      Box.GlyphType.corner(.light, type: .bottomLeading): "╰",
      Box.GlyphType.corner(.light, type: .bottomTrailing): "╯",

    ], sharp)

  public static let test = Box.GlyphSet.partial(
    [

      Box.GlyphType.horizontal(.strong): "M",  // ░

      Box.GlyphType.vertical(.strong): "S",

      Box.GlyphType.join(x: .strong, y: .strong, type: .top): "T",
      Box.GlyphType.join(x: .strong, y: .strong, type: .bottom): "B",
      Box.GlyphType.join(x: .strong, y: .strong, type: .leading): "L",
      Box.GlyphType.join(x: .strong, y: .strong, type: .trailing): "R",

      Box.GlyphType.corner(.regular, type: .topLeading): "r",
      Box.GlyphType.corner(.regular, type: .topTrailing): "a",
      Box.GlyphType.corner(.regular, type: .bottomLeading): "m",
      Box.GlyphType.corner(.regular, type: .bottomTrailing): "s",

    ], sharp)

  public static let double = Box.GlyphSet.partial(
    [

      Box.GlyphType.horizontal(.strong): "═",
      Box.GlyphType.horizontal(.light): "─",

      Box.GlyphType.vertical(.strong): "║",
      Box.GlyphType.vertical(.light): "│",

      Box.GlyphType.join(x: .strong, y: .light, type: .top): "╤",
      Box.GlyphType.join(x: .strong, y: .light, type: .bottom): "╧",
      Box.GlyphType.join(x: .light, y: .strong, type: .leading): "╟",
      Box.GlyphType.join(x: .light, y: .strong, type: .trailing): "╢",
      Box.GlyphType.join(x: .light, y: .light, type: .cross): "┼",

      Box.GlyphType.corner(.strong, type: .topLeading): "╔",
      Box.GlyphType.corner(.strong, type: .topTrailing): "╗",
      Box.GlyphType.corner(.strong, type: .bottomLeading): "╚",
      Box.GlyphType.corner(.strong, type: .bottomTrailing): "╝",

      Box.GlyphType.corner(.light, type: .topLeading): "┌",
      Box.GlyphType.corner(.light, type: .topTrailing): "┐",
      Box.GlyphType.corner(.light, type: .bottomLeading): "└",
      Box.GlyphType.corner(.light, type: .bottomTrailing): "┘",

    ], sharp)

}

extension Character {
  public static var blank: Character { " " }
}
