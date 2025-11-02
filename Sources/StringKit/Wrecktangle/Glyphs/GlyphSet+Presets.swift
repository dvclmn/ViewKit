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
      Box.GlyphType.horizontal(.bold): "━",
      Box.GlyphType.horizontal(.thin): "─",

      // MARK: - Walls
      Box.GlyphType.vertical(.bold): "┃",
      Box.GlyphType.vertical(.thin): "│",

      // MARK: - Exterior-to-Interior Join
      Box.GlyphType.join(weightX: .bold, weightY: .thin, type: .top): "┯",
      Box.GlyphType.join(weightX: .bold, weightY: .thin, type: .bottom): "┷",
      Box.GlyphType.join(weightX: .thin, weightY: .bold, type: .leading): "┠",
      Box.GlyphType.join(weightX: .thin, weightY: .bold, type: .trailing): "┨",

      // MARK: - Exterior-to-Exterior Join
      Box.GlyphType.join(weightX: .bold, weightY: .bold, type: .top): "┳",
      Box.GlyphType.join(weightX: .bold, weightY: .bold, type: .bottom): "┻",
      Box.GlyphType.join(weightX: .bold, weightY: .bold, type: .leading): "┣",
      Box.GlyphType.join(weightX: .bold, weightY: .bold, type: .trailing): "┫",

      // MARK: - Interior-to-Interior Join
      Box.GlyphType.join(weightX: .thin, weightY: .thin, type: .top): "┬",
      Box.GlyphType.join(weightX: .thin, weightY: .thin, type: .bottom): "┴",
      Box.GlyphType.join(weightX: .thin, weightY: .thin, type: .leading): "├",
      Box.GlyphType.join(weightX: .thin, weightY: .thin, type: .trailing): "┤",
      Box.GlyphType.join(weightX: .thin, weightY: .thin, type: .cross): "┼",

      // MARK: - Exterior Corner
      Box.GlyphType.corner(weight: .bold, type: .topLeading): "┏",
      Box.GlyphType.corner(weight: .bold, type: .topTrailing): "┓",
      Box.GlyphType.corner(weight: .bold, type: .bottomLeading): "┗",
      Box.GlyphType.corner(weight: .bold, type: .bottomTrailing): "┛",

      // MARK: - Interior Corner
      Box.GlyphType.corner(weight: .thin, type: .topLeading): "┌",
      Box.GlyphType.corner(weight: .thin, type: .topTrailing): "┐",
      Box.GlyphType.corner(weight: .thin, type: .bottomLeading): "└",
      Box.GlyphType.corner(weight: .thin, type: .bottomTrailing): "┘",

    ]
  )

  public static let rounded = Box.GlyphSet.partial(
    [

      Box.GlyphType.horizontal(.bold): "─",
      ///
      Box.GlyphType.vertical(.bold): "│",
      ///
      Box.GlyphType.join(weightX: .bold, weightY: .bold, type: .top): "┬",
      Box.GlyphType.join(weightX: .bold, weightY: .bold, type: .bottom): "┴",
      Box.GlyphType.join(weightX: .bold, weightY: .bold, type: .leading): "├",
      Box.GlyphType.join(weightX: .bold, weightY: .bold, type: .trailing): "┤",
      Box.GlyphType.join(weightX: .bold, weightY: .bold, type: .cross): "┼",
      ///
      Box.GlyphType.corner(type: .topLeading): "╭",
      Box.GlyphType.corner(type: .topTrailing): "╮",
      Box.GlyphType.corner(type: .bottomLeading): "╰",
      Box.GlyphType.corner(type: .bottomTrailing): "╯",

    ], sharp)
  
  public static let test = Box.GlyphSet.partial(
    [
      
      Box.GlyphType.horizontal(.bold): "M", // ░
      ///
      Box.GlyphType.vertical(.bold): "S",
      
      Box.GlyphType.join(weightX: .bold, weightY: .bold, type: .top): "T",
      Box.GlyphType.join(weightX: .bold, weightY: .bold, type: .bottom): "B",
      Box.GlyphType.join(weightX: .bold, weightY: .bold, type: .leading): "L",
      Box.GlyphType.join(weightX: .bold, weightY: .bold, type: .trailing): "R",
      
      Box.GlyphType.corner(type: .topLeading): "r",
      Box.GlyphType.corner(type: .topTrailing): "a",
      Box.GlyphType.corner(type: .bottomLeading): "m",
      Box.GlyphType.corner(type: .bottomTrailing): "s",
      
    ], sharp)

  public static let double = Box.GlyphSet.partial(
    [

      Box.GlyphType.horizontal(.bold): "═",
      Box.GlyphType.horizontal(.thin): "─",
      ///
      Box.GlyphType.vertical(.bold): "║",
      Box.GlyphType.vertical(.thin): "│",
      ///
      Box.GlyphType.join(weightX: .bold, weightY: .thin, type: .top): "╤",
      Box.GlyphType.join(weightX: .bold, weightY: .thin, type: .bottom): "╧",
      Box.GlyphType.join(weightX: .thin, weightY: .bold, type: .leading): "╟",
      Box.GlyphType.join(weightX: .thin, weightY: .bold, type: .trailing): "╢",
      Box.GlyphType.join(weightX: .thin, weightY: .thin, type: .cross): "┼",
      ///
      Box.GlyphType.corner(weight: .bold, type: .topLeading): "╔",
      Box.GlyphType.corner(weight: .bold, type: .topTrailing): "╗",
      Box.GlyphType.corner(weight: .bold, type: .bottomLeading): "╚",
      Box.GlyphType.corner(weight: .bold, type: .bottomTrailing): "╝",
      ///
      Box.GlyphType.corner(weight: .thin, type: .topLeading): "┌",
      Box.GlyphType.corner(weight: .thin, type: .topTrailing): "┐",
      Box.GlyphType.corner(weight: .thin, type: .bottomLeading): "└",
      Box.GlyphType.corner(weight: .thin, type: .bottomTrailing): "┘",

    ], sharp)

}

extension Character {
  public static var blank: Character { " " }
}
