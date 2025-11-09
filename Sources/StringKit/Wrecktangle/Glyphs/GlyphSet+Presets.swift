//
//  Glyphs.swift
//  BoxCore
//
//  Created by Dave Coleman on 23/8/2024.
//

import Foundation


/// This attempts to describe a glyph based on it's usage,
/// rather than neccesarily it's appearance / visual qualitites
//extension Box.GlyphSet {
//
//  public static let sharp = Box.GlyphSet.base(
//    [
//      Glyph.blank: Character.blank,
//
//      // MARK: - Floor/Ceiling
//      Glyph.horizontal(.increased): "━",
//      Glyph.horizontal(.standard): "─",
//
//      // MARK: - Walls
//      Glyph.vertical(.increased): "┃",
//      Glyph.vertical(.standard): "│",
//
//      // MARK: - Bold to Thin Joins
//      Glyph.join(x: .increased, y: .standard, type: .top): "┯",
//      Glyph.join(x: .increased, y: .standard, type: .bottom): "┷",
//      Glyph.join(x: .standard, y: .increased, type: .leading): "┠",
//      Glyph.join(x: .standard, y: .increased, type: .trailing): "┨",
//      Glyph.join(x: .standard, y: .increased, type: .cross): "╂",
//
//      // MARK: - Bold Joins
//      Glyph.join(x: .increased, y: .increased, type: .top): "┳",
//      Glyph.join(x: .increased, y: .increased, type: .bottom): "┻",
//      Glyph.join(x: .increased, y: .increased, type: .leading): "┣",
//      Glyph.join(x: .increased, y: .increased, type: .trailing): "┫",
//      Glyph.join(x: .increased, y: .increased, type: .cross): "╋",
//
//      // MARK: - Thin Joins
//      Glyph.join(x: .standard, y: .standard, type: .top): "┬",
//      Glyph.join(x: .standard, y: .standard, type: .bottom): "┴",
//      Glyph.join(x: .standard, y: .standard, type: .leading): "├",
//      Glyph.join(x: .standard, y: .standard, type: .trailing): "┤",
//      Glyph.join(x: .standard, y: .standard, type: .cross): "┼",
//
//      // MARK: - Bold Corners
//      Glyph.corner(.increased, type: .topLeading): "┏",
//      Glyph.corner(.increased, type: .topTrailing): "┓",
//      Glyph.corner(.increased, type: .bottomLeading): "┗",
//      Glyph.corner(.increased, type: .bottomTrailing): "┛",
//
//      // MARK: - Thin Corners
//      Glyph.corner(.standard, type: .topLeading): "┌",
//      Glyph.corner(.standard, type: .topTrailing): "┐",
//      Glyph.corner(.standard, type: .bottomLeading): "└",
//      Glyph.corner(.standard, type: .bottomTrailing): "┘",
//    ]
//  )
//
//  public static let rounded = Box.GlyphSet.partial(
//    [
//      Glyph.horizontal(.increased): "─",
//      Glyph.horizontal(.standard): "─",
//
//      // MARK: - Walls
//      Glyph.vertical(.increased): "│",
//      Glyph.vertical(.standard): "│",
//
//      Glyph.join(x: .standard, y: .standard, type: .top): "┬",
//      Glyph.join(x: .standard, y: .standard, type: .bottom): "┴",
//      Glyph.join(x: .standard, y: .standard, type: .leading): "├",
//      Glyph.join(x: .standard, y: .standard, type: .trailing): "┤",
//      Glyph.join(x: .standard, y: .standard, type: .cross): "┼",
//
//      Glyph.corner(.standard, type: .topLeading): "╭",
//      Glyph.corner(.standard, type: .topTrailing): "╮",
//      Glyph.corner(.standard, type: .bottomLeading): "╰",
//      Glyph.corner(.standard, type: .bottomTrailing): "╯",
//
//    ], sharp)
//
//  public static let test = Box.GlyphSet.partial(
//
//    [
//      Glyph.blank: Character.blank,
//
//      // MARK: - Floor/Ceiling
//      Glyph.horizontal(.increased): "━",  // H
//      Glyph.horizontal(.standard): "─",  // *
//      Glyph.vertical(.increased): "┃",  // V
//      Glyph.vertical(.standard): "│",  // &
//
//      // MARK: - Bold to Thin Joins
//      Glyph.join(x: .increased, y: .standard, type: .top): "B",  // ┯
//      Glyph.join(x: .increased, y: .standard, type: .bottom): "B",  // ┷
//      Glyph.join(x: .standard, y: .increased, type: .leading): "B",  // ┠
//      Glyph.join(x: .standard, y: .increased, type: .trailing): "B",  // ┨
//
//      // MARK: - Bold Joins
//      Glyph.join(x: .increased, y: .increased, type: .top): "A",  // ┳
//      Glyph.join(x: .increased, y: .increased, type: .bottom): "A",  // ┻
//      Glyph.join(x: .increased, y: .increased, type: .leading): "A",  // ┣
//      Glyph.join(x: .increased, y: .increased, type: .trailing): "A",  // ┫
//      Glyph.join(x: .increased, y: .increased, type: .cross): "A",  // ╋
//
//      // MARK: - Thin Joins
//      Glyph.join(x: .standard, y: .standard, type: .top): "C",  // ┬
//      Glyph.join(x: .standard, y: .standard, type: .bottom): "C",  // ┴
//      Glyph.join(x: .standard, y: .standard, type: .leading): "C",  // ├
//      Glyph.join(x: .standard, y: .standard, type: .trailing): "C",  // ┤
//      Glyph.join(x: .standard, y: .standard, type: .cross): "C",  // ┼
//
//      // MARK: - Bold Corners
//      Glyph.corner(.increased, type: .topLeading): "┏",
//      Glyph.corner(.increased, type: .topTrailing): "┓",
//      Glyph.corner(.increased, type: .bottomLeading): "┗",
//      Glyph.corner(.increased, type: .bottomTrailing): "┛",
//
//      // MARK: - Thin Corners
//      Glyph.corner(.standard, type: .topLeading): "┌",
//      Glyph.corner(.standard, type: .topTrailing): "┐",
//      Glyph.corner(.standard, type: .bottomLeading): "└",
//      Glyph.corner(.standard, type: .bottomTrailing): "┘",
//
//    ], sharp)
//
//  public static let double = Box.GlyphSet.partial(
//    [
//
//      Glyph.horizontal(.increased): "═",
//      Glyph.horizontal(.standard): "─",
//
//      Glyph.vertical(.increased): "║",
//      Glyph.vertical(.standard): "│",
//
//      Glyph.join(x: .increased, y: .standard, type: .top): "╤",
//      Glyph.join(x: .increased, y: .standard, type: .bottom): "╧",
//      Glyph.join(x: .standard, y: .increased, type: .leading): "╟",
//      Glyph.join(x: .standard, y: .increased, type: .trailing): "╢",
//      Glyph.join(x: .standard, y: .standard, type: .cross): "┼",
//
//      Glyph.corner(.increased, type: .topLeading): "╔",
//      Glyph.corner(.increased, type: .topTrailing): "╗",
//      Glyph.corner(.increased, type: .bottomLeading): "╚",
//      Glyph.corner(.increased, type: .bottomTrailing): "╝",
//
//      Glyph.corner(.standard, type: .topLeading): "┌",
//      Glyph.corner(.standard, type: .topTrailing): "┐",
//      Glyph.corner(.standard, type: .bottomLeading): "└",
//      Glyph.corner(.standard, type: .bottomTrailing): "┘",
//
//    ], sharp)
//
//}

extension Character {
  public static var blank: Character { " " }
}
