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
      Box.GlyphType.horizontal(.thin): "─",

      // MARK: - Walls
      Box.GlyphType.vertical(.strong): "┃",
      Box.GlyphType.vertical(.thin): "│",

      // MARK: - Bold to Thin Joins
      Box.GlyphType.join(x: .strong, y: .thin, type: .top): "┯",
      Box.GlyphType.join(x: .strong, y: .thin, type: .bottom): "┷",
      Box.GlyphType.join(x: .thin, y: .strong, type: .leading): "┠",
      Box.GlyphType.join(x: .thin, y: .strong, type: .trailing): "┨",

      // MARK: - Bold Joins
      Box.GlyphType.join(x: .strong, y: .strong, type: .top): "┳",
      Box.GlyphType.join(x: .strong, y: .strong, type: .bottom): "┻",
      Box.GlyphType.join(x: .strong, y: .strong, type: .leading): "┣",
      Box.GlyphType.join(x: .strong, y: .strong, type: .trailing): "┫",
      Box.GlyphType.join(x: .strong, y: .strong, type: .cross): "╋",

      // MARK: - Thin Joins
      Box.GlyphType.join(x: .thin, y: .thin, type: .top): "┬",
      Box.GlyphType.join(x: .thin, y: .thin, type: .bottom): "┴",
      Box.GlyphType.join(x: .thin, y: .thin, type: .leading): "├",
      Box.GlyphType.join(x: .thin, y: .thin, type: .trailing): "┤",
      Box.GlyphType.join(x: .thin, y: .thin, type: .cross): "┼",

      // MARK: - Bold Corners
      Box.GlyphType.corner(.strong, type: .topLeading): "┏",
      Box.GlyphType.corner(.strong, type: .topTrailing): "┓",
      Box.GlyphType.corner(.strong, type: .bottomLeading): "┗",
      Box.GlyphType.corner(.strong, type: .bottomTrailing): "┛",

      // MARK: - Thin Corners
      Box.GlyphType.corner(.thin, type: .topLeading): "┌",
      Box.GlyphType.corner(.thin, type: .topTrailing): "┐",
      Box.GlyphType.corner(.thin, type: .bottomLeading): "└",
      Box.GlyphType.corner(.thin, type: .bottomTrailing): "┘",

    ]
  )

  public static let rounded = Box.GlyphSet.partial(
    [

      Box.GlyphType.horizontal(.thin): "─",
      
      Box.GlyphType.vertical(.thin): "│",
      
      Box.GlyphType.join(x: .thin, y: .thin, type: .top): "┬",
      Box.GlyphType.join(x: .thin, y: .thin, type: .bottom): "┴",
      Box.GlyphType.join(x: .thin, y: .thin, type: .leading): "├",
      Box.GlyphType.join(x: .thin, y: .thin, type: .trailing): "┤",
      Box.GlyphType.join(x: .thin, y: .thin, type: .cross): "┼",
      
      Box.GlyphType.corner(.thin, type: .topLeading): "╭",
      Box.GlyphType.corner(.thin, type: .topTrailing): "╮",
      Box.GlyphType.corner(.thin, type: .bottomLeading): "╰",
      Box.GlyphType.corner(.thin, type: .bottomTrailing): "╯",

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
      Box.GlyphType.horizontal(.thin): "─",

      Box.GlyphType.vertical(.strong): "║",
      Box.GlyphType.vertical(.thin): "│",

      Box.GlyphType.join(x: .strong, y: .thin, type: .top): "╤",
      Box.GlyphType.join(x: .strong, y: .thin, type: .bottom): "╧",
      Box.GlyphType.join(x: .thin, y: .strong, type: .leading): "╟",
      Box.GlyphType.join(x: .thin, y: .strong, type: .trailing): "╢",
      Box.GlyphType.join(x: .thin, y: .thin, type: .cross): "┼",

      Box.GlyphType.corner(.strong, type: .topLeading): "╔",
      Box.GlyphType.corner(.strong, type: .topTrailing): "╗",
      Box.GlyphType.corner(.strong, type: .bottomLeading): "╚",
      Box.GlyphType.corner(.strong, type: .bottomTrailing): "╝",

      Box.GlyphType.corner(.thin, type: .topLeading): "┌",
      Box.GlyphType.corner(.thin, type: .topTrailing): "┐",
      Box.GlyphType.corner(.thin, type: .bottomLeading): "└",
      Box.GlyphType.corner(.thin, type: .bottomTrailing): "┘",

    ], sharp)

}

extension Character {
  public static var blank: Character { " " }
}
