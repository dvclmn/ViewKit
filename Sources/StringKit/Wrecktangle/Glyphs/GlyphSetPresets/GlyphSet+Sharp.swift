//
//  GlyphSet+Sharp.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 9/11/2025.
//

extension Box.GlyphSet {
  
  public static var sharp: Self {
    GlyphSet(.sharp) {
      Glyph.blank
      
      // MARK: - Floor/Ceiling
      Glyph("━", .horizontal, weight: .increased, design: .sharp)
      Glyph("─", .horizontal, design: .sharp)
      
      
      
      // MARK: - Walls
      Glyph("┃", .vertical, weight: .increased)
      Glyph("│", .vertical)
      
      Glyph("┯", .join(.top), x: .increased)
      
      // MARK: - Bold to Thin Joins
      Glyph.join(x: .increased, y: .standard, type: .top): "┯",
      Glyph.join(x: .increased, y: .standard, type: .bottom): "┷",
      Glyph.join(x: .standard, y: .increased, type: .leading): "┠",
      Glyph.join(x: .standard, y: .increased, type: .trailing): "┨",
      Glyph.join(x: .standard, y: .increased, type: .cross): "╂",
      
      // MARK: - Bold Joins
      Glyph.join(x: .increased, y: .increased, type: .top): "┳",
      Glyph.join(x: .increased, y: .increased, type: .bottom): "┻",
      Glyph.join(x: .increased, y: .increased, type: .leading): "┣",
      Glyph.join(x: .increased, y: .increased, type: .trailing): "┫",
      Glyph.join(x: .increased, y: .increased, type: .cross): "╋",
      
      // MARK: - Thin Joins
      Glyph.join(x: .standard, y: .standard, type: .top): "┬",
      Glyph.join(x: .standard, y: .standard, type: .bottom): "┴",
      Glyph.join(x: .standard, y: .standard, type: .leading): "├",
      Glyph.join(x: .standard, y: .standard, type: .trailing): "┤",
      Glyph.join(x: .standard, y: .standard, type: .cross): "┼",
      
      // MARK: - Bold Corners
      Glyph.corner(.increased, type: .topLeading): "┏",
      Glyph.corner(.increased, type: .topTrailing): "┓",
      Glyph.corner(.increased, type: .bottomLeading): "┗",
      Glyph.corner(.increased, type: .bottomTrailing): "┛",
      
      // MARK: - Thin Corners
      Glyph.corner(.standard, type: .topLeading): "┌",
      Glyph.corner(.standard, type: .topTrailing): "┐",
      Glyph.corner(.standard, type: .bottomLeading): "└",
      Glyph.corner(.standard, type: .bottomTrailing): "┘",
    }
    
  }
  
}
