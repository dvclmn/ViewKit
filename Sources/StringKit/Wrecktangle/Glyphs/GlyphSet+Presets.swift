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
      Box.GlyphType.horizontal(.exterior): "━",
      Box.GlyphType.horizontal(.interior): "─",

      // MARK: - Walls
      Box.GlyphType.vertical(.exterior): "┃",
      Box.GlyphType.vertical(.interior): "│",

      // MARK: - Exterior-to-Interior Join
      Box.GlyphType.join(x: .exterior, y: .interior, type: .top): "┯",
      Box.GlyphType.join(x: .exterior, y: .interior, type: .bottom): "┷",
      Box.GlyphType.join(x: .interior, y: .exterior, type: .leading): "┠",
      Box.GlyphType.join(x: .interior, y: .exterior, type: .trailing): "┨",

      // MARK: - Exterior-to-Exterior Join
      Box.GlyphType.join(x: .exterior, y: .exterior, type: .top): "┳",
      Box.GlyphType.join(x: .exterior, y: .exterior, type: .bottom): "┻",
      Box.GlyphType.join(x: .exterior, y: .exterior, type: .leading): "┣",
      Box.GlyphType.join(x: .exterior, y: .exterior, type: .trailing): "┫",

      // MARK: - Interior-to-Interior Join
      Box.GlyphType.join(x: .interior, y: .interior, type: .top): "┬",
      Box.GlyphType.join(x: .interior, y: .interior, type: .bottom): "┴",
      Box.GlyphType.join(x: .interior, y: .interior, type: .leading): "├",
      Box.GlyphType.join(x: .interior, y: .interior, type: .trailing): "┤",
      Box.GlyphType.join(x: .interior, y: .interior, type: .cross): "┼",

      // MARK: - Exterior Corner
      Box.GlyphType.corner(location: .exterior, type: .topLeading): "┏",
      Box.GlyphType.corner(location: .exterior, type: .topTrailing): "┓",
      Box.GlyphType.corner(location: .exterior, type: .bottomLeading): "┗",
      Box.GlyphType.corner(location: .exterior, type: .bottomTrailing): "┛",

      // MARK: - Interior Corner
      Box.GlyphType.corner(location: .interior, type: .topLeading): "┌",
      Box.GlyphType.corner(location: .interior, type: .topTrailing): "┐",
      Box.GlyphType.corner(location: .interior, type: .bottomLeading): "└",
      Box.GlyphType.corner(location: .interior, type: .bottomTrailing): "┘",

    ]
  )

  public static let rounded = Box.GlyphSet.partial(
    [

      Box.GlyphType.horizontal(.exterior): "─",
      ///
      Box.GlyphType.vertical(.exterior): "│",
      ///
      Box.GlyphType.join(x: .exterior, y: .exterior, type: .top): "┬",
      Box.GlyphType.join(x: .exterior, y: .exterior, type: .bottom): "┴",
      Box.GlyphType.join(x: .exterior, y: .exterior, type: .leading): "├",
      Box.GlyphType.join(x: .exterior, y: .exterior, type: .trailing): "┤",
      Box.GlyphType.join(x: .exterior, y: .exterior, type: .cross): "┼",
      ///
      Box.GlyphType.corner(type: .topLeading): "╭",
      Box.GlyphType.corner(type: .topTrailing): "╮",
      Box.GlyphType.corner(type: .bottomLeading): "╰",
      Box.GlyphType.corner(type: .bottomTrailing): "╯",

    ], sharp)

  public static let double = Box.GlyphSet.partial(
    [

      Box.GlyphType.horizontal(.exterior): "═",
      Box.GlyphType.horizontal(.interior): "─",
      ///
      Box.GlyphType.vertical(.exterior): "║",
      Box.GlyphType.vertical(.interior): "│",
      ///
      Box.GlyphType.join(x: .exterior, y: .interior, type: .top): "╤",
      Box.GlyphType.join(x: .exterior, y: .interior, type: .bottom): "╧",
      Box.GlyphType.join(x: .interior, y: .exterior, type: .leading): "╟",
      Box.GlyphType.join(x: .interior, y: .exterior, type: .trailing): "╢",
      Box.GlyphType.join(x: .interior, y: .interior, type: .cross): "┼",
      ///
      Box.GlyphType.corner(location: .exterior, type: .topLeading): "╔",
      Box.GlyphType.corner(location: .exterior, type: .topTrailing): "╗",
      Box.GlyphType.corner(location: .exterior, type: .bottomLeading): "╚",
      Box.GlyphType.corner(location: .exterior, type: .bottomTrailing): "╝",
      ///
      Box.GlyphType.corner(location: .interior, type: .topLeading): "┌",
      Box.GlyphType.corner(location: .interior, type: .topTrailing): "┐",
      Box.GlyphType.corner(location: .interior, type: .bottomLeading): "└",
      Box.GlyphType.corner(location: .interior, type: .bottomTrailing): "┘",

    ], sharp)

}

extension Character {
  public static var blank: Character { " " }
}
