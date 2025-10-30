//
//  Glyphs.swift
//  BoxCore
//
//  Created by Dave Coleman on 23/8/2024.
//

import Foundation

extension Box.GlyphSet {

//  public typealias GlyphType = Box.GlyphType

  public static let sharp = Box.GlyphSet.base(
    [
      Box.GlyphType.blank: " ",
      ///
      Box.GlyphType.horizontal(.exterior): "━",
      Box.GlyphType.horizontal(.interior): "─",
      ///
      Box.GlyphType.vertical(.exterior): "┃",
      Box.GlyphType.vertical(.interior): "│",
      ///
      Box.GlyphType.join(x: .exterior, y: .interior, type: .top): "┯",
      Box.GlyphType.join(x: .exterior, y: .interior, type: .bottom): "┷",
      Box.GlyphType.join(x: .interior, y: .exterior, type: .leading): "┠",
      Box.GlyphType.join(x: .interior, y: .exterior, type: .trailing): "┨",
      ///
      Box.GlyphType.join(x: .interior, y: .interior, type: .top): "┬",
      Box.GlyphType.join(x: .interior, y: .interior, type: .bottom): "┴",
      Box.GlyphType.join(x: .interior, y: .interior, type: .leading): "├",
      Box.GlyphType.join(x: .interior, y: .interior, type: .trailing): "┤",
      Box.GlyphType.join(x: .interior, y: .interior, type: .cross): "┼",
      ///
      Box.GlyphType.corner(location: .exterior, type: .topLeading): "┏",
      Box.GlyphType.corner(location: .exterior, type: .topTrailing): "┓",
      Box.GlyphType.corner(location: .exterior, type: .bottomLeading): "┗",
      Box.GlyphType.corner(location: .exterior, type: .bottomTrailing): "┛",
      ///
      Box.GlyphType.corner(location: .interior, type: .topLeading): "┌",
      Box.GlyphType.corner(location: .interior, type: .topTrailing): "┐",
      Box.GlyphType.corner(location: .interior, type: .bottomLeading): "└",
      Box.GlyphType.corner(location: .interior, type: .bottomTrailing): "┘",

    ]
  )

  public static let rounded = Box.GlyphSet.fallback(
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

  public static let double = Box.GlyphSet.fallback(
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
