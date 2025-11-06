//
//  PartType+Build.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 2/11/2025.
//

import Foundation
import SharedHelpers

extension Box.PartType {

  /// We return a `StringStack`, not a `String`, to allow
  /// any additional repeating/joining required further down the pipeline.
  public func buildPart(
    using engine: Box.Engine,
    position: Box.PositionContext,
    span: Box.PartSpan = .single,
  ) -> StringStack {

    let part = part(using: engine, position: position)
//    print("Building Part: \(part)")
    let stringStack = part.toStringStack(with: engine.theme)

    switch span {
      case .fill:
        return stringStack.repeated(
          along: .horizontal,
          count: engine.width(for: .repeatedPart)
        )

      case .fixed(let count):
        return if count == 1 {
          stringStack
        } else {
          stringStack.repeated(along: .horizontal, count: count)
        }

    }
  }

  func part(
    using engine: Box.Engine,
    position: Box.PositionContext
  ) -> Part {
    switch engine.theme.frameStyle {
      case .single: singleFrameParts()
      case .double: doubleFrameParts()
      case .notebook: notebookParts(position: position)
    }  // END switch
  }
}

extension StringStack {
  public init(
    from glyphStack: Box.GlyphStack,
    with theme: Box.Theme,
  ) {
//    print("Making StringStack from GlyphStack \(glyphStack) and Theme \(theme)")
    /// Convert from `GlyphType` → `Character`
    let characterGrid = glyphStack.map { row in
//      print("Processing row \(row)")
      return row.map {
        let char = theme.glyphSet.character(for: $0)
//        print("Character: \(char)")
        return char
      }
    }
//    print("Character Grid: \(characterGrid)")
    
    self.init(characterGrid)
  }

}
