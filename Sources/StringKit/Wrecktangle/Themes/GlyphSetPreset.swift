//
//  Glyphs.swift
//  BoxCore
//
//  Created by Dave Coleman on 23/8/2024.
//

import Foundation

extension Box.GlyphSet {

  public typealias GlyphType = Box.GlyphType

  public static let sharp = Box.GlyphSet.base([

    GlyphType.blank: " ",
    ///
    GlyphType.horizontal(.exterior): "━",
    GlyphType.horizontal(.interior): "─",
    ///
    GlyphType.vertical(.exterior): "┃",
    GlyphType.vertical(.interior): "│",
    ///
    GlyphType.join(x: .exterior, y: .interior, type: .top): "┯",
    GlyphType.join(x: .exterior, y: .interior, type: .bottom): "┷",
    GlyphType.join(x: .interior, y: .exterior, type: .leading): "┠",
    GlyphType.join(x: .interior, y: .exterior, type: .trailing): "┨",
    ///
    GlyphType.join(x: .interior, y: .interior, type: .top): "┬",
    GlyphType.join(x: .interior, y: .interior, type: .bottom): "┴",
    GlyphType.join(x: .interior, y: .interior, type: .leading): "├",
    GlyphType.join(x: .interior, y: .interior, type: .trailing): "┤",
    GlyphType.join(x: .interior, y: .interior, type: .cross): "┼",
    ///
    GlyphType.corner(location: .exterior, type: .topLeading): "┏",
    GlyphType.corner(location: .exterior, type: .topTrailing): "┓",
    GlyphType.corner(location: .exterior, type: .bottomLeading): "┗",
    GlyphType.corner(location: .exterior, type: .bottomTrailing): "┛",
    ///
    GlyphType.corner(location: .interior, type: .topLeading): "┌",
    GlyphType.corner(location: .interior, type: .topTrailing): "┐",
    GlyphType.corner(location: .interior, type: .bottomLeading): "└",
    GlyphType.corner(location: .interior, type: .bottomTrailing): "┘",

  ])

  public static let rounded = Box.GlyphSet.fallback(
    [

      GlyphType.horizontal(): "─",
      ///
      GlyphType.vertical(): "│",
      ///
      GlyphType.join(type: .top): "┬",
      GlyphType.join(type: .bottom): "┴",
      GlyphType.join(type: .leading): "├",
      GlyphType.join(type: .trailing): "┤",
      GlyphType.join(type: .cross): "┼",
      ///
      GlyphType.corner(type: .topLeading): "╭",
      GlyphType.corner(type: .topTrailing): "╮",
      GlyphType.corner(type: .bottomLeading): "╰",
      GlyphType.corner(type: .bottomTrailing): "╯",

    ], sharp)

  public static let double = Box.GlyphSet.fallback(
    [

      GlyphType.horizontal(.exterior): "═",
      GlyphType.horizontal(.interior): "─",
      ///
      GlyphType.vertical(.exterior): "║",
      GlyphType.vertical(.interior): "│",
      ///
      GlyphType.join(x: .exterior, y: .interior, type: .top): "╤",
      GlyphType.join(x: .exterior, y: .interior, type: .bottom): "╧",
      GlyphType.join(x: .interior, y: .exterior, type: .leading): "╟",
      GlyphType.join(x: .interior, y: .exterior, type: .trailing): "╢",
      GlyphType.join(x: .interior, y: .interior, type: .cross): "┼",
      ///
      GlyphType.corner(location: .exterior, type: .topLeading): "╔",
      GlyphType.corner(location: .exterior, type: .topTrailing): "╗",
      GlyphType.corner(location: .exterior, type: .bottomLeading): "╚",
      GlyphType.corner(location: .exterior, type: .bottomTrailing): "╝",
      ///
      GlyphType.corner(location: .interior, type: .topLeading): "┌",
      GlyphType.corner(location: .interior, type: .topTrailing): "┐",
      GlyphType.corner(location: .interior, type: .bottomLeading): "└",
      GlyphType.corner(location: .interior, type: .bottomTrailing): "┘",

    ], sharp)

}
