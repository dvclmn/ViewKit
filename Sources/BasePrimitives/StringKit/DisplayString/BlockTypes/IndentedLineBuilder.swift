//
//  IndentedLineBuilder.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 26/3/2026.
//

import Foundation

package struct IndentedLineBuilder {
  let indent: String
  
  /// Controls which glyph set is used when drawing the tree structure.
  /// Defaults to `.rounded` to match the previous behavior.
  let glyphStyle: IndentGlyphStyle = .rounded
  
  /// Convenience accessor for the concrete glyphs of the selected style.
  private var glyphs: IndentGlyphs { glyphStyle.glyphs }
  
  /// Builds a list of indented, tree-like lines from the provided element strings.
  /// - Parameter elements: Each element may span multiple lines. The first line
  ///   receives a branch prefix; subsequent lines receive a continuation prefix.
  mutating func build(from elements: [String]) -> [String] {
    var result: [String] = []
    
    for (index, element) in elements.enumerated() {
      let isLastItem = index == elements.count - 1
      let lines = element.lines()
      
      for (lineIndex, line) in lines.enumerated() {
        if lineIndex == 0 {
          /// First line of this element: draw a branch (join or corner) followed by a horizontal.
          result.append(prefixForFirstLine(isLastItem: isLastItem) + " " + line)
        } else {
          /// Continuation lines: keep the column aligned; show a vertical if there are following siblings.
          result.append(continuationPrefix(isLastItem: isLastItem) + line)
        }
      }
    }
    
    return result
  }
  
  /// Prefix for the first line of an element.
  /// Uses a joining glyph when there are more siblings after this item,
  /// or a corner glyph when this is the last item.
  private func prefixForFirstLine(isLastItem: Bool) -> String {
    let branch: Character = isLastItem ? glyphs.corner : glyphs.join
    return "\(branch)\(glyphs.horizontal)"
  }
  
  /// Prefix for continuation (wrapped) lines of an element.
  /// Shows a vertical bar when there are more siblings after this item
  /// to visually carry the column; otherwise uses a space.
  private func continuationPrefix(isLastItem: Bool) -> String {
    let lead = isLastItem ? " " : String(glyphs.vertical)
    return lead + indent
  }
}
